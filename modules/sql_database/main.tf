# main.tf in modules/sql_database

# SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                         = "${var.environment}-${var.sql_server_name}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_password

  tags = var.tags
}

# SQL Database
resource "azurerm_mssql_database" "sql_database" {
  name         = "${var.environment}-${var.sql_database_name}"
  server_id    = azurerm_mssql_server.sql_server.id
  max_size_gb  = var.max_size_gb
  sku_name     = var.sku_name
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  enclave_type = "VBS"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false # set to true to prevent accidental deletion
  }

  tags = var.tags

}