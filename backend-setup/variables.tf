# variables.tf
variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default = "rg-opera-backend-state"
}

variable "storage_container_name" {
  description = "storage container name"
  type        = string
  default     = "tfstate"
}

variable "backend_storage_name" {
    description = "The name of the storage account"
    type        = string
    default = "backendstorageopera"
}

variable "subscription_id" {
    description = "The subscription ID"
    type        = string
}