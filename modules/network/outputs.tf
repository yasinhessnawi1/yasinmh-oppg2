output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "website_subnet_id" {
  description = "The ID of the website Service Subnet"
  value       = azurerm_subnet.website_subnet.id
}

output "db_subnet_id" {
  description = "The ID of the SQL Database Subnet"
  value       = azurerm_subnet.db_subnet.id
}