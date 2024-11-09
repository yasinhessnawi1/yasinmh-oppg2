# Defines the deployment environment, such as 'dev', 'staging', or 'prod'.
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

# Specifies the Azure region where the resources will be deployed.
variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}

# Name of the resource group in which the Service Plan will be created.
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Name assigned to the website Service Plan, used for creating a unique resource identifier.
variable "website_service_plan_name" {
  description = "Name of the website Service Plan"
  type        = string
}

# The SKU (pricing tier) for the Service Plan, allowing specification of different performance and cost tiers.
variable "sku_name" {
  description = "SKU for the website Service Plan"
  type        = string
}

# Tags to categorize and manage the Service Plan. This helps in organizing resources and tracking related costs.
variable "tags" {
  description = "Tags to assign to the website Service Plan"
  type        = map(string)
}
