# main.tf in modules/app_service_plan
resource "azurerm_service_plan" "website_service_plan" {
  name                = "${var.environment}-${var.website_service_plan_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  os_type = "Linux"
  sku_name = var.sku_name
  tags = var.tags
}