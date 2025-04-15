variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "vnet_cidr_blocks" {
  description = "CIDR blocks for virtual networks"
  type        = list(string)
  default     = ["10.0.0.0/16", "10.2.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Address prefixes for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "nsg_names" {
  description = "Names for network security groups"
  type        = list(string)
  default     = ["web", "app", "db"]
}

variable "nsg_ports" {
  description = "Ports for network security groups"
  type        = list(number)
  default     = [80, 8080, 3306]
}

# New map variables for for_each
variable "vnet_config" {
  description = "Map of virtual network configurations"
  type        = map(string)
  default = {
    "production"  = "10.0.0.0/16"
    "development" = "10.2.0.0/16"
  }
}

variable "subnet_config" {
  description = "Map of subnet configurations"
  type        = map(string)
  default = {
    "web"  = "10.0.1.0/24"
    "app"  = "10.0.2.0/24"
    "data" = "10.0.3.0/24"
  }
}

variable "nsg_ports_map" {
  description = "Map of NSG ports"
  type        = map(number)
  default = {
    "http"  = 80
    "https" = 443
    "app"   = 8080
    "db"    = 3306
    "redis" = 6379 # Added new entry
  }
}

variable "route_tables" {
  description = "Map of route tables to create"
  type        = map(string)
  default = {
    "public"  = "Internet-facing routes"
    "private" = "Internal-only routes"
    "gateway" = "Gateway routes"
  }
}