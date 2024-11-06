# main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.2.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-opera-terraform-state"  #see global/backend-setup/global.tfvars
    storage_account_name = "backendstorageopera" # see global/backend-setup/global.tfvars
    container_name       = "tfstate" # see global/backend-setup/global.tfvars
    key                  = "terraform.tfstate"
  }
}


resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group_name}-${random_string.suffix.result}"
  location = var.location
}




