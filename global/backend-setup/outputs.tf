
output "resource_group_name" {
  value = azurerm_resource_group.backend_rg.name
}

output "storage_container_name" {
  value = azurerm_storage_container.tfstate.name
}

output "backend_storage_name" {
  value = azurerm_storage_account.backend_storage.name
}