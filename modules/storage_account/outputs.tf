# modules/storage_account/outputs.tf

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

# outputs.tf in modules/blob_storage
output "blob_container_name" {
  description = "The name of the Blob container"
  value       = azurerm_storage_container.blob_container.name
}

output "storage_account_access_key" {
  value = azurerm_storage_account.storage.primary_access_key
}