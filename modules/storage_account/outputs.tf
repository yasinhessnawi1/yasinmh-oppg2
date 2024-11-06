# modules/storage_account/outputs.tf

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}

output "storage_account_access_key" {
  value = azurerm_storage_account.storage.primary_access_key
}