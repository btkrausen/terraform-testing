resource "github_branch_protection" "this" {
  repository_id = var.repository_name
  pattern       = var.branch

  enforce_admins = var.enforce_admins

  require_signed_commits = var.require_signed_commits
  allows_deletions       = var.allows_deletions
  allows_force_pushes    = var.allows_force_pushes

  dynamic "required_status_checks" {
    for_each = var.required_status_checks != null ? [var.required_status_checks] : []
    content {
      strict   = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = var.required_pull_request_reviews != null ? [var.required_pull_request_reviews] : []
    content {
      dismiss_stale_reviews           = required_pull_request_reviews.value.dismiss_stale_reviews
      restrict_dismissals             = required_pull_request_reviews.value.restrict_dismissals
      require_code_owner_reviews      = required_pull_request_reviews.value.require_code_owner_reviews
      required_approving_review_count = required_pull_request_reviews.value.required_approving_review_count
      dismissal_restrictions          = required_pull_request_reviews.value.dismissal_restrictions
    }
  }
}