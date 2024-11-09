# Backend setup for Terraform state storage on Azure

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id # Subscription ID where resources are provisioned
}

# Resource group for backend infrastructure
resource "azurerm_resource_group" "backend_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Storage account for storing Terraform state files
resource "azurerm_storage_account" "backend_storage" {
  name                     = var.backend_storage_name # Must be globally unique
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # Locally redundant storage
}

# Container within the storage account for the state file
resource "azurerm_storage_container" "tfstate" {
  name                  = var.storage_container_name
  storage_account_id    = azurerm_storage_account.backend_storage.id
  container_access_type = "private" # Ensures state file access is restricted
}
