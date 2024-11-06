# variables.tf
variable "environment" {
  description = "The environment to deploy to (e.g., dev, staging, prod)"
  type        = string
}

variable "subscription_id" {
    description = "The subscription ID"
    type        = string
}


variable "key_vault_access_policies" {
    description = "List of access policies for the Azure Key Vault"
    type = list(object({
        tenant_id           = string
        object_id           = string
        secret_permissions  = list(string)
        key_permissions     = list(string)
        storage_permissions = list(string)
    }))
}

