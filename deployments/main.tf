provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

data "terraform_remote_state" "global" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-opera-terraform-state"      # Resource group for the backend
    storage_account_name = "backendstorageopera"           # Storage account name for state
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Fetch current client configuration
data "azurerm_client_config" "current" {}

# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 4
  special = false
  lower   = true
  numeric = false
  upper   = false
}

# Network Module
module "network" {
  source              = "../modules/network"
  environment         = var.environment
  location            = data.terraform_remote_state.global.outputs.location
  resource_group_name = data.terraform_remote_state.global.outputs.resource_group_name
}

# Storage Module
module "storage" {
  source              = "../modules/storage_account"
  environment         = var.environment
  location            = data.terraform_remote_state.global.outputs.location
  resource_group_name = data.terraform_remote_state.global.outputs.resource_group_name
  name                = "storage${random_string.suffix.result}"
}

# Key Vault Module
module "key_vault" {
  source                     = "../modules/key_vault"
  environment                = var.environment
  location                   = data.terraform_remote_state.global.outputs.location
  resource_group_name        = data.terraform_remote_state.global.outputs.resource_group_name
  key_vault_name             = "kv-${var.environment}-${random_string.suffix.result}"
  storage_account_access_key = module.storage.storage_account_access_key  # Ensure storage module outputs this key

  access_policies = [
    {
      tenant_id           = data.azurerm_client_config.current.tenant_id
      object_id           = data.azurerm_client_config.current.object_id
      secret_permissions  = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
      key_permissions     = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore"]
      storage_permissions = ["Get", "List", "Delete", "Set", "Update"]
    }
  ]

  tenant_id = data.azurerm_client_config.current.tenant_id
}

# Optional Outputs for Debugging
output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "object_id" {
  value = data.azurerm_client_config.current.object_id
}