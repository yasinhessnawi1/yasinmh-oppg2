# network module variables
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
}


variable "location" {
  description = "The Azure region for resource deployment"
  type        = string
  default     = "westeurope"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "vnet-operaterraas"
}

variable "app_subnet_name" {
  description = "The name of the subnet used for the application"
  type        = string
  default     = "app_subnet-operaterraas"
}
variable "db_subnet_name" {
  description = "The name of the subnet used for the database"
  type        = string
  default     = "db_subnet-operaterraas"
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "app_subnet_prefix" {
  description = "The address prefix for the app service subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "db_subnet_prefix" {
  description = "The address prefix for the database subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
  default     = "nsg-operaterraas"
}

variable "security_rules" {
  description = "List of security rules for the NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "allow-ssh"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "192.168.1.0/24"
      destination_address_prefix = "*"
    }
  ]
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {
    Owner       = "OperaTerra AS"
    ManagedBy   = "Terraform"
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}