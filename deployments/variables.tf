variable "environment" {
    description = "The environment to deploy to (e.g., dev, staging, prod)"
    type        = string
}

variable "subscription_id" {
    description = "The subscription ID"
    type        = string
}

variable "backend_resource_group_name" {
    description = "The name of the resource group for the backend storage account"
    type        = string
}

variable "backend_storage_account_name" {
    description = "The name of the storage account for the backend"
    type        = string
}

variable "backend_container_name" {
    description = "The name of the storage container for the backend"
    type        = string
    default     = "tfstate"
}

variable "blob_container_name" {
    description = "The name of the blob container"
    type        = string
    default     = "blob-container-data-storage"
}

variable "default_tags" {
    description = "Default tags to apply to resources"
    type        = map(string)
    default     = {
        Owner     = "OperaTerra AS"
        ManagedBy = "Terraform"
    }
}

variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
}