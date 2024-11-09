# This variable defines default tags that will be applied to all resources created by this Terraform configuration.
variable "default_tags" {
  description = "Default tags to apply to resources" # Helps identify the ownership and management of the resources.
  type        = map(string)                          # Specifies that the variable is a map of strings (key-value pairs).
  default = {
    Owner     = "OperaTerra AS" # Default tag indicating the owner of the resources.
    ManagedBy = "Terraform"     # Default tag indicating the resource management tool.
  }
}

# This variable holds the name of the resource group to be created or used for deployment.
variable "resource_group_name" {
  description = "The name of the resource group to deploy to" # Provides context for users to set or override this variable as needed.
  type        = string
}

# This variable specifies the Azure region where the resources will be deployed.
variable "location" {
  description = "The Azure region to deploy to" # Indicates the location for resource deployment in Azure.
  type        = string
  default     = "westeurope" # Sets a default location to West Europe if not explicitly overridden.
}

# This variable holds the subscription ID required to authenticate with Azure.
variable "subscription_id" {
  description = "The subscription ID" # Helps identify the specific Azure subscription to deploy resources.
  type        = string
}
