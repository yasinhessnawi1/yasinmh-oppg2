# main.tf in modules/load_balancer

# Frontend IP configuration
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.environment}-lb-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

# Load Balancer
resource "azurerm_lb" "load_balancer" {
  name                = "${var.environment}-load-balancer"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }

  tags = var.tags
}
