# outputs.tf in modules/app_service_plan
output "website_service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.website_service_plan.id
}
