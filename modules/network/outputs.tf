# Output to expose the Virtual Network ID
output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id # Outputs the ID of the created Virtual Network
}

# Output to expose the ID of the website subnet
output "website_subnet_id" {
  description = "The ID of the website Service Subnet"
  value       = azurerm_subnet.website_subnet.id # Outputs the ID of the created website subnet
}

# Output to expose the ID of the database subnet
output "db_subnet_id" {
  description = "The ID of the SQL Database Subnet"
  value       = azurerm_subnet.db_subnet.id # Outputs the ID of the created database subnet
}
