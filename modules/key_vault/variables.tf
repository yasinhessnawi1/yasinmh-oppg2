variable "key_vault_name" {
    description = "Name of the Azure Key Vault"
    type        = string
}

variable "resource_group_name" {
    description = "Name of the Azure Resource Group"
    type        = string
}

variable "location" {
    description = "Azure region for the Key Vault"
    type        = string
}


variable "tenant_id" {
    description = "Azure Active Directory tenant ID for Key Vault"
    type        = string
}

variable "enabled_for_disk_encryption" {
    description = "Whether the Key Vault is enabled for disk encryption"
    type        = bool
    default     = false
}

variable "purge_protection_enabled" {
    description = "Whether purge protection is enabled for the Key Vault"
    type        = bool
    default     = true
}

variable "sku_name" {
    description = "SKU Name for the Key Vault"
    type        = string
    default     = "standard"
}

variable "access_policies" {
    description = "List of access policies for the Azure Key Vault"
    type = list(object({
        tenant_id           = string
        object_id           = string
        secret_permissions  = list(string)
        key_permissions     = list(string)
        storage_permissions = list(string)
    }))
}

variable "storage_account_access_key" {
    description = "The access key for the Azure Storage Account (sensitive)"
    type        = string
    sensitive   = true
}

variable "tags" {
    description = "Tags to be applied to all resources."
    type        = map(string)
}

variable "sql_admin_password" {
    description = "The password for the SQL Server admin account (sensitive)"
    type        = string
    sensitive   = true
}

variable "sql_admin_login" {
    description = "The login for the SQL Server admin account"
    type        = string
    sensitive = true
}