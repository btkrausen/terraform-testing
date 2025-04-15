variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "vnet_count" {
  description = "Number of virtual networks to create"
  type        = number
  default     = 3
}

variable "vnet_address_spaces" {
  description = "Address spaces for virtual networks"
  type        = list(string)
  default     = ["10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16"]
}

variable "subnet_count" {
  description = "Number of subnets to create in the first VNet"
  type        = number
  default     = 2
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for subnets"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "nsg_configs" {
  description = "Network security group configurations"
  type = list(object({
    name         = string
    rule_name    = string
    port         = number
    source_addrs = string
  }))
  default = [
    {
      name         = "web"
      rule_name    = "allow-http"
      port         = 80
      source_addrs = "*"
    },
    {
      name         = "app"
      rule_name    = "allow-app"
      port         = 8080
      source_addrs = "10.1.0.0/16"
    },
    {
      name         = "db"
      rule_name    = "allow-sql"
      port         = 1433
      source_addrs = "10.1.0.0/16"
    }
  ]
}