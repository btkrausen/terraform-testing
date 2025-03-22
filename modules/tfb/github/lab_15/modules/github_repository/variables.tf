variable "name" {
  description = "Name of the repository"
  type        = string
}

variable "description" {
  description = "Description of the repository"
  type        = string
  default     = ""
}

variable "visibility" {
  description = "Visibility of the repository"
  type        = string
  default     = "public"
  validation {
    condition     = contains(["public", "private", "internal"], var.visibility)
    error_message = "Visibility must be one of: public, private, or internal."
  }
}

variable "has_issues" {
  description = "Enable issues feature"
  type        = bool
  default     = true
}

variable "has_projects" {
  description = "Enable projects feature"
  type        = bool
  default     = false
}

variable "has_wiki" {
  description = "Enable wiki feature"
  type        = bool
  default     = false
}

variable "auto_init" {
  description = "Initialize the repository with a README"
  type        = bool
  default     = true
}

variable "gitignore_template" {
  description = "Gitignore template to use"
  type        = string
  default     = null
}

variable "license_template" {
  description = "License template to use"
  type        = string
  default     = null
}

variable "topics" {
  description = "List of topics for the repository"
  type        = list(string)
  default     = []
}

variable "template" {
  description = "Template repository to use"
  type = object({
    owner      = string
    repository = string
  })
  default = null
}