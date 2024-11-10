# Terraform block specifying the required providers and backend configuration.
# The backend is configured to use Azure Storage for storing the Terraform state file.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.2.0" # Ensures a compatible version of the AzureRM provider is used.
    }
  }

  # Backend configuration for remote state storage, crucial for collaboration and maintaining state consistency.
  backend "azurerm" {
    resource_group_name  = "rg-opera-terraform-state" # Name of the resource group containing the backend state resources.
    storage_account_name = "backendstorageopera"      # Name of the storage account used for storing the Terraform state.
    container_name       = "tfstate"                  # Name of the container where the state file is stored.
    key                  = "global/terraform.tfstate" # The state file path within the container.
  }
}

# Configures the AzureRM provider with necessary features and subscription ID.
provider "azurerm" {
  features {}                           # Enables all optional features by default.
  subscription_id = var.subscription_id # Uses the subscription ID passed as a variable for resource creation.
}

# Generates a random string to ensure globally unique resource names, which helps avoid name collisions.
resource "random_string" "suffix" {
  length  = 6     # Specifies the length of the generated string.
  special = false # Excludes special characters to ensure valid resource names.
  upper   = false # Uses only lowercase characters.
  numeric = true  # Includes numeric characters.
}

# Creates the main resource group for deploying resources, ensuring the name is unique using the random suffix.
resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group_name}-${random_string.suffix.result}" # Combines the base name with the random suffix.
  location = var.location                                                # The region where the resource group will be created.
  tags     = var.default_tags                                            # Applies default tags for better management and tracking.
}

