variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "tflab16"
}

variable "repository_visibility" {
  description = "Repository visibility setting"
  type        = string
  default     = "public"
}

variable "repository_description" {
  description = "Description for the repository"
  type        = string
  default     = "Repository created for Terraform Lab 16"
}

variable "repository_topics" {
  description = "Topics for the repository"
  type        = list(string)
  default     = ["terraform", "lab", "example"]
}

variable "auto_init" {
  description = "Initialize repository with README"
  type        = bool
  default     = true
}

variable "gitignore_template" {
  description = "Template for gitignore file"
  type        = string
  default     = "Terraform"
}

variable "random_suffix_length" {
  description = "Length of random suffix for unique resource names"
  type        = number
  default     = 6
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