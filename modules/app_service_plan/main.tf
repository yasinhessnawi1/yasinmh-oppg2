# Create an Azure App Service Plan for hosting web applications.
resource "azurerm_service_plan" "website_service_plan" {
  # Name of the service plan, incorporating the environment for uniqueness.
  name = "${var.environment}-${var.website_service_plan_name}"

  # Location where the service plan will be deployed.
  location = var.location

  # Resource group in which the service plan will be created.
  resource_group_name = var.resource_group_name

  # OS type for the app service plan. Here, we are specifying Linux.
  os_type = "Linux"

  # Specifies the SKU tier and size for the app service plan.
  sku_name = var.sku_name

  # Tags applied to the service plan for resource management and organization.
  tags = var.tags
}
