# modules/storage_account/variables.tf

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "location" {
  description = "Azure region to deploy the resources in"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "name" {
  description = "The name for the storage account, must be globally unique"
  type        = string
}
