# Specifies the deployment environment, indicating that this configuration is for the production environment.
environment = "prod"

# The Azure subscription ID used for this deployment. This should match the target Azure account for the production environment.
subscription_id = "c07d12e1-5880-4a69-837d-8004c99145fc"

# The name of the Azure resource group that hosts the backend storage for the Terraform remote state.
backend_resource_group_name = "rg-opera-terraform-state"

# The name of the Azure storage account used for storing the Terraform state file.
backend_storage_account_name = "backendstorageopera"
