variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "repository_names" {
  description = "List of repository name suffixes"
  type        = list(string)
  default     = ["api", "web", "docs", "utils", "cli"]
}

variable "team_members" {
  description = "List of team members with duplicates"
  type        = list(string)
  default     = ["user1", "user2", "user3", "user1", "user4"]
}

variable "topics" {
  description = "List of repository topics"
  type        = list(string)
  default     = ["terraform", "infrastructure", "devops", "automation"]
}