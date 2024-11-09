# deployments/main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.2.0"
    }
  }

  backend "azurerm" {
    # Backend configuration will be supplied via -backend-config during terraform init
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Fetch the global remote state
data "terraform_remote_state" "global" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-opera-terraform-state"
    storage_account_name = "backendstorageopera"
    container_name       = "tfstate"
    key                  = "global/terraform.tfstate"
  }
}

# Fetch current client configuration
data "azurerm_client_config" "current" {}
# Retrieve the SQL admin login and password from Key Vault

# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

resource "random_string" "sql_admin_login" {
  length           = 10
  special          = false
  upper            = false
  lower            = true
}
resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}<>"
}

# Locals for environment-specific customization
locals {
  # Adjust SKU names based on environment
  sku_name_service_plan = var.environment == "prod" ? "S1" : "B1"
    sku_name_sql_db       = var.environment == "prod" ? "S0" : "Basic"
  tags     = merge(var.default_tags, { "Environment" = var.environment })
}

# Network Module
module "network" {
  source              = "../modules/network"
  environment         = var.environment
  location            = data.terraform_remote_state.global.outputs.location
  resource_group_name = data.terraform_remote_state.global.outputs.resource_group_name
  tags                = local.tags
}

# Storage Module with random name generation
module "storage" {
  source               = "../modules/storage_account"
  environment          = var.environment
  location             = data.terraform_remote_state.global.outputs.location
  resource_group_name  = data.terraform_remote_state.global.outputs.resource_group_name
  name                 = "storage${random_string.suffix.result}"
  blob_container_name  = var.blob_container_name
  tags                 = local.tags
}

# Key Vault Module
module "key_vault" {
  source                     = "../modules/key_vault"
  environment                = var.environment
  location                   = data.terraform_remote_state.global.outputs.location
  resource_group_name        = data.terraform_remote_state.global.outputs.resource_group_name
  key_vault_name             = "${var.environment}-kv-${random_string.suffix.result}"
  storage_account_access_key = module.storage.storage_account_access_key
  sql_admin_login = random_string.sql_admin_login.result
  sql_admin_password = random_password.sql_admin_password.result
  access_policies            = [
    {
      tenant_id           = data.azurerm_client_config.current.tenant_id
      object_id           = data.azurerm_client_config.current.object_id
      secret_permissions  = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
      key_permissions     = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore"]
      storage_permissions = ["Get", "List", "Delete", "Set", "Update"]
    }
  ]
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  tags                       = local.tags
}

# App Service Plan Module
module "app_service_plan" {
  source                    = "../modules/app_service_plan"
  environment               = var.environment
  location                  = data.terraform_remote_state.global.outputs.location
  resource_group_name       = data.terraform_remote_state.global.outputs.resource_group_name
  website_service_plan_name = "webapp-plan-${random_string.suffix.result}"
  sku_name                  = local.sku_name_service_plan
  tags                      = local.tags
}


# Load Balancer Module
module "load_balancer" {
  source              = "../modules/load_balancer"
  environment         = var.environment
  location            = data.terraform_remote_state.global.outputs.location
  resource_group_name = data.terraform_remote_state.global.outputs.resource_group_name
  tags                = local.tags
}

# SQL Database Module
module "sql_database" {
  source                  = "../modules/sql_database"
  environment             = var.environment
  location                = data.terraform_remote_state.global.outputs.location
  resource_group_name     = data.terraform_remote_state.global.outputs.resource_group_name
  sql_server_name         = "sqlserver-${random_string.suffix.result}"
  sql_database_name       = "productdb-${random_string.suffix.result}"
  administrator_login     = random_string.sql_admin_login.result
  administrator_password  = random_password.sql_admin_password.result
  sku_name                = local.sku_name_sql_db
  tags                    = local.tags
  max_size_gb =             var.max_size_gb
}