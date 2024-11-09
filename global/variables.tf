variable "default_tags" {
  description = "Default tags to apply to resources"
  type        = map(string)
  default     = {
    Owner     = "OperaTerra AS"
    ManagedBy = "Terraform"
  }
}

variable "resource_group_name" {
    description = "The name of the resource group to deploy to"
    type        = string
}

variable "location" {
    description = "The Azure region to deploy to"
    type        = string
    default     = "westeurope"
}

variable "subscription_id" {
    description = "The subscription ID"
    type        = string
}