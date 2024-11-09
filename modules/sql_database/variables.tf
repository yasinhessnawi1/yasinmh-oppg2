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

variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}

variable "administrator_login" {
  description = "SQL Server admin username"
  type        = string
}

variable "administrator_password" {
  description = "SQL Server admin password"
  type        = string
  sensitive   = true
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the SQL Database (e.g., S0, S1)"
  type        = string

}

variable "max_size_gb" {
  description = "Maximum size of the database in gigabytes"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags to assign to the SQL resources"
  type        = map(string)
}

variable "sql_version" {
  description = "The version of SQL Server to deploy"
  type        = string
  default     = "12.0"
}