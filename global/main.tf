# global/main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.2.0"
    }
  }
  backend "azurerm" {
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}


# Random suffix for globally unique resource names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

# Local variables for environment-specific customization
locals {
  environment = var.environment
  tags = merge(var.default_tags, {
    "Environment" = var.environment
  })
}

# Main resource group
resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group_name}-${random_string.suffix.result}"
  location = var.location
  tags     = local.tags
}




