# key_vault/main.tf
# Data source to get current Azure client configuration
data "azurerm_client_config" "current" {}

# Creates the key vault resource
resource "azurerm_key_vault" "key_vault" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  tenant_id                   = var.tenant_id
  purge_protection_enabled    = var.purge_protection_enabled
  sku_name                    = var.sku_name

  # Dynamic access policies from variable
  dynamic "access_policy" {
    for_each = var.access_policies
    content {
      tenant_id           = access_policy.value.tenant_id
      object_id           = access_policy.value.object_id
      secret_permissions  = access_policy.value.secret_permissions
      key_permissions     = access_policy.value.key_permissions
      storage_permissions = access_policy.value.storage_permissions
    }
  }

  tags = var.tags
}

# Creates a key vault secret for the storage account key
resource "azurerm_key_vault_secret" "storage_account_key" {
  name         = "storage-account-key"
  value        = var.storage_account_access_key
  key_vault_id = azurerm_key_vault.key_vault.id

  lifecycle {
    prevent_destroy = false
  }
}

resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}<>"
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-login-password"
  value        = random_password.sql_admin_password.result
  key_vault_id = azurerm_key_vault.key_vault.id

  lifecycle {
    prevent_destroy = false
  }
}

resource "random_string" "sql_admin_login" {
  length           = 10
  special          = false
  upper            = false
  lower            = true
}

resource "azurerm_key_vault_secret" "sql_admin_login" {
  name         = "sql-admin-login"
  value        = random_string.sql_admin_login.result
  key_vault_id = azurerm_key_vault.key_vault.id

  lifecycle {
    prevent_destroy = false
  }
}
