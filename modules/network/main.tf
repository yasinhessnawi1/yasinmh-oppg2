# Local variables for commonly used values
locals {
  rg_name  = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-${var.vnet_name}"
  resource_group_name = local.rg_name
  location            = local.location
  address_space       = var.address_space
  tags                = local.tags
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.environment}-${var.nsg_name}"
  location            = local.location
  resource_group_name = local.rg_name
  tags                = local.tags

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

# Associate NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "nsg_subnet_assoc" {
  subnet_id                 = azurerm_subnet.website_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create a subnet for the website service
resource "azurerm_subnet" "website_subnet" {
  name                 = "${var.environment}-${var.website_subnet_name}"
  resource_group_name  = local.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.website_subnet_prefix
}

# Create a subnet for the SQL database
resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.environment}-${var.db_subnet_name}"
  resource_group_name  = local.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.db_subnet_prefix
}