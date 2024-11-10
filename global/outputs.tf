# Outputs the name of the main resource group created by the Terraform configuration.
output "resource_group_name" {
  description = "The name of the resource group" # Provides context for the output, indicating what it represents.
  value       = azurerm_resource_group.main.name # References the `name` attribute of the `azurerm_resource_group.main` resource.
}

# Outputs the location/region where the main resource group is deployed.
output "location" {
  description = "The region where resources are deployed" # Specifies what this output represents, aiding users in understanding its purpose.
  value       = azurerm_resource_group.main.location      # References the `location` attribute of the `azurerm_resource_group.main` resource.
}
