# variables.tf
variable "environment" {
  description = "The environment to deploy to (e.g., dev, staging, prod)"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "backend_resource_group_name" {
    description = "The name of the resource group for the backend storage account"
    type        = string
}

variable "backend_container_name" {
    description = "The name of the storage container"
    type        = string
    default     = "tfstate"
}

variable "backend_storage_account_name" {
    description = "The name of the storage account"
    type        = string
}

variable "subscription_id" {
    description = "The subscription ID"
    type        = string
}