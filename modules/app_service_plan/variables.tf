# variables.tf in modules/app_service_plan
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "website_service_plan_name" {
  description = "Name of the website Service Plan"
  type        = string
}

variable "sku_name" {
  description = "SKU for the website Service Plan"
  type        = string
}


variable "tags" {
  description = "Tags to assign to the website Service Plan"
  type        = map(string)
}