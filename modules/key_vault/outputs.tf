

# outputs the storage account key id
output "storage_account_key_secret_id" {
  value = azurerm_key_vault_secret.storage_account_key.id
}

# outputs the key vault id
output "key_vault_id" {
  value = azurerm_key_vault.key_vault.id
}