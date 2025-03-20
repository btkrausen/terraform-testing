variable "repo_names" {
  description = "Names for repositories"
  type        = list(string)
  default     = ["repo-1", "repo-2", "repo-3"]
}

variable "label_names" {
  description = "Names for issue labels"
  type        = list(string)
  default     = ["bug", "feature"]
}

variable "label_colors" {
  description = "Colors for issue labels"
  type        = list(string)
  default     = ["FF0000", "00FF00"]
}

# New map variables for for_each
variable "repositories" {
  description = "Map of repository configurations"
  type        = map(string)
  default = {
    "api"      = "API service repository"
    "web"      = "Web frontend repository"
    "database" = "Database schema repository"
  }
}

variable "branch_patterns" {
  description = "Map of branch patterns to protect"
  type        = map(string)
  default = {
    "main"    = "Main branch"
    "release" = "Release branch"
  }
}

variable "label_config" {
  description = "Map of label configurations"
  type        = map(string)
  default = {
    "bug"      = "FF0000"
    "feature"  = "00FF00"
    "docs"     = "0000FF"
    "test"     = "FFFF00"
    "security" = "FF00FF"
  }
}

variable "repo_files" {
  description = "Map of repository files"
  type        = map(string)
  default = {
    "README.md"       = "# Repository README\nThis is a sample repository."
    "CONTRIBUTING.md" = "# Contributing Guidelines\nHow to contribute to this project."
    "LICENSE"         = "MIT License\nCopyright (c) 2023"
  }
}

