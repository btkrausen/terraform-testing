variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "repo_visibility" {
  description = "Repository visibility"
  type        = string
  default     = "public"
}

variable "default_branch" {
  description = "Default repository branch"
  type        = string
  default     = "main"
}