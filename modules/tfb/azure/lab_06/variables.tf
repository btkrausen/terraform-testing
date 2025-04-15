# Add variables below
variable "environment" {
  description = "Environment name for resource naming and tagging"
  type        = string
  default     = "production"
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "eastus"
}

variable "vnet_address_space" {
  description = "Address space for Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  description = "Address prefix for subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "dynamic-infrastructure"
}