variable "github_token_full" {
  description = "GitHub Personal Access Token with full repository access"
  type        = string
  sensitive   = true
}

variable "github_token_readonly" {
  description = "GitHub Personal Access Token with read-only access"
  type        = string
  sensitive   = true
}

variable "repo_name" {
  description = "Name of the GitHub repository to be created"
  type        = string
  default     = "terraform-repo-for-alias-demo"
}