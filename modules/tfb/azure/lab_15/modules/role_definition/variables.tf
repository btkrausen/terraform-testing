variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "role_name" {
  description = "Name of the custom role"
  type        = string
}

variable "scope" {
  description = "The scope at which the Role Definition applies to"
  type        = string
}

variable "permissions" {
  description = "List of permissions that are granted by the role"
  type = object({
    actions          = list(string)
    data_actions     = list(string)
    not_actions      = list(string)
    not_data_actions = list(string)
  })
  default = {
    actions          = []
    data_actions     = []
    not_actions      = []
    not_data_actions = []
  }
}

variable "description" {
  description = "Description of the role"
  type        = string
  default     = ""
}