variable "repo_count" {
  description = "Number of repositories to create"
  type        = number
  default     = 3
}

variable "repo_names" {
  description = "Names for repositories"
  type        = list(string)
  default     = ["example-repo-1", "example-repo-2", "example-repo-3"]
}

variable "label_repositories" {
  description = "Repositories to add labels to"
  type        = list(number)
  default     = [0, 1] # Indexes of repos to add labels to
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

variable "label_descriptions" {
  description = "Descriptions for issue labels"
  type        = list(string)
  default     = ["Bug issues", "Feature requests"]
}

variable "readme_count" {
  description = "Number of README files to create"
  type        = number
  default     = 2
}