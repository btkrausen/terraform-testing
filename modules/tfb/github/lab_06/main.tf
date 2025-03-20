data "github_user" "current" {
  username = ""
}

# Static configuration with hardcoded values
resource "github_repository" "production" {
  name        = "${var.environment}-${var.app_name}"
  description = "${title(var.environment)} environment repository managed by ${data.github_user.current.login}"
  visibility  = "public"

  has_issues      = var.repository_features.has_issues
  has_wiki        = var.repository_features.has_wiki
  has_discussions = var.repository_features.has_discussions

  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true

  topics = [
    var.environment,
    var.app_name,
    "terraform-managed",
  ]
}