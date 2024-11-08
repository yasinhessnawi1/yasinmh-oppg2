# deployments/main.tf

terraform {
  required_version = ">= 0.14"

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
    resource_group_name  = var.backend_resource_group_name
    storage_account_name = var.backend_storage_account_name
    container_name       = var.backend_container_name
    key                  = "global/${var.environment}.tfstate"
  }
}

# Fetch current client configuration
data "azurerm_client_config" "current" {}

# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

# Locals for environment-specific customization
locals {
  # Adjust SKU names based on environment
  sku_name = var.environment == "prod" ? "S1" : "B1"
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
  key_vault_name             = "kv-${var.environment}-${random_string.suffix.result}"
  storage_account_access_key = module.storage.storage_account_access_key
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
  sku_name                  = local.sku_name
  tags                      = local.tags
}

# Retrieve the SQL admin login and password from Key Vault
data "azurerm_key_vault_secret" "sql_admin_login" {
  name         = "sql-admin-login"
  key_vault_id = module.key_vault.key_vault_id
}

data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-login-password"
  key_vault_id = module.key_vault.key_vault_id
}

# SQL Database Module
module "sql_database" {
  source                  = "../modules/sql_database"
  environment             = var.environment
  location                = data.terraform_remote_state.global.outputs.location
  resource_group_name     = data.terraform_remote_state.global.outputs.resource_group_name
  sql_server_name         = "sqlserver-${random_string.suffix.result}"
  sql_database_name       = "productdb-${random_string.suffix.result}"
  administrator_login     = data.azurerm_key_vault_secret.sql_admin_login.value
  administrator_password  = data.azurerm_key_vault_secret.sql_admin_password.value
  sku_name                = local.sku_name
  tags                    = local.tags
}

# Load Balancer Module
module "load_balancer" {
  source              = "../modules/load_balancer"
  environment         = var.environment
  location            = data.terraform_remote_state.global.outputs.location
  resource_group_name = data.terraform_remote_state.global.outputs.resource_group_name
  tags                = local.tags
}
