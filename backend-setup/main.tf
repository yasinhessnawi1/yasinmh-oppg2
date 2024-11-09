# backend-setup/main.tf
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "backend_rg" {
  name     = var.resource_group_name
  location = var.location # Adjust as needed
}

resource "azurerm_storage_account" "backend_storage" {
  name                     = var.backend_storage_name  # Globally unique name
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.storage_container_name
  storage_account_id  = azurerm_storage_account.backend_storage.id
  container_access_type = "private"
}