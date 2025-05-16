variable "azure_location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "tf"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "lab_name" {
  description = "Lab identifier for tagging"
  type        = string
  default     = "lab16"
}

variable "random_suffix_length" {
  description = "Length of random suffix for unique resource names"
  type        = number
  default     = 4
}

variable "allowed_ip_ranges" {
  description = "List of allowed IP ranges for the storage account"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "storage_account_tag_name" {
  description = "Name tag for the storage account"
  type        = string
  default     = "example-storage"
}

variable "role_definition_name" {
  description = "Name of the built-in role definition"
  type        = string
  default     = "Storage Blob Data Reader"
}

variable "policy_description" {
  description = "Description for the Azure policy"
  type        = string
  default     = "Example policy for lab exercises"
}

variable "special_chars_allowed" {
  description = "Allow special characters in random string"
  type        = bool
  default     = false
}

variable "upper_chars_allowed" {
  description = "Allow uppercase characters in random string"
  type        = bool
  default     = false
}