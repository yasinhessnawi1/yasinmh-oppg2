output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "app_subnet_id" {
  description = "The ID of the App Service Subnet"
  value       = azurerm_subnet.app_subnet.id
}

output "db_subnet_id" {
  description = "The ID of the SQL Database Subnet"
  value       = azurerm_subnet.db_subnet.id
}