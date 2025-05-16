variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "locations" {
  description = "List of Azure regions"
  type        = list(string)
  default     = ["eastus", "westus", "centralus"]
}

variable "address_spaces" {
  description = "Address spaces for virtual networks"
  type        = list(string)
  default     = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Subnet address prefixes"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "teams" {
  description = "List of teams (with duplicates)"
  type        = list(string)
  default     = ["dev", "ops", "dev", "security", "data", "ops"]
}