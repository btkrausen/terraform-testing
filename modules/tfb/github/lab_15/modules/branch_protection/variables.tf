variable "repository_name" {
  description = "Name of the repository"
  type        = string
}

variable "branch" {
  description = "Branch to protect"
  type        = string
  default     = "main"
}

variable "enforce_admins" {
  description = "Enforce on repository administrators"
  type        = bool
  default     = true
}

variable "require_signed_commits" {
  description = "Require signed commits"
  type        = bool
  default     = false
}

variable "required_status_checks" {
  description = "Status checks that are required"
  type = object({
    strict   = bool
    contexts = list(string)
  })
  default = null
}

variable "required_pull_request_reviews" {
  description = "Pull request review requirements"
  type = object({
    dismiss_stale_reviews           = bool
    restrict_dismissals             = bool
    require_code_owner_reviews      = bool
    required_approving_review_count = number
    dismissal_restrictions          = list(string)
  })
  default = null
}

variable "push_restrictions" {
  description = "List of user/team names with push access"
  type        = list(string)
  default     = []
}

variable "allows_deletions" {
  description = "Allow users with push access to delete the branch"
  type        = bool
  default     = false
}

variable "allows_force_pushes" {
  description = "Allow force pushes to the branch"
  type        = bool
  default     = false
}