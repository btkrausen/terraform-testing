variable "repository_visibility" {
  description = "Repo visibility configuration"
  type        = string
  default     = "public"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

variable "user_repos" {
  description = "Map of users"
  type        = map(string)
  default = {
    user1 = "kristen"
    user2 = "aaron"
    user3 = "jack"
    user4 = "frank"
    user5 = "monica"
  }
}

variable "repo_org" {
  description = "Organization name"
  type        = string
  default     = "my-org"
}