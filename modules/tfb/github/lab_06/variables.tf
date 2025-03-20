# Add variables below
variable "environment" {
  description = "Environment name for resource naming"
  type        = string
  default     = "production"
}

variable "app_name" {
  description = "Application name for repository"
  type        = string
  default     = "application"
}

variable "repository_features" {
  description = "Enabled features for repository"
  type = object({
    has_issues      = bool
    has_wiki        = bool
    has_discussions = bool
  })
  default = {
    has_issues      = true
    has_wiki        = true
    has_discussions = true
  }
}