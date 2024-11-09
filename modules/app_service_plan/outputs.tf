# Output variable to expose the ID of the App Service Plan created by this module.
output "website_service_plan_id" {
  # Description provides context for the output, useful for understanding what this output represents.
  description = "ID of the App Service Plan"

  # The value retrieves the ID of the created App Service Plan, allowing other modules or configurations to reference it.
  value = azurerm_service_plan.website_service_plan.id
}
