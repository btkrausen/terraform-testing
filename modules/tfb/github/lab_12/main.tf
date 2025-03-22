# Standard repository without lifecycle configuration
resource "github_repository" "standard" {
  name        = "standard-${var.environment}-repo"
  description = "Standard repository for ${var.environment} environment"
  visibility  = var.repo_visibility
  auto_init   = true

  topics = ["terraform", "lifecycle-demo"]
}

# Issue label without lifecycle configuration
resource "github_issue_label" "standard" {
  repository  = github_repository.standard.name
  name        = "standard"
  color       = "FF0000"
  description = "Standard issue label"
}

# Repository with prevent_destroy
resource "github_repository" "protected" {
  name        = "protected-${var.environment}-repo"
  description = "Protected repository for ${var.environment} environment"
  visibility  = var.repo_visibility
  auto_init   = true

  topics = ["terraform", "lifecycle-demo", "protected"]
}

# Issue with ignore_changes
resource "github_issue_label" "ignored" {
  repository  = github_repository.protected.name
  name        = "standard"
  color       = "FF0000"
  description = "Protected issue label"

  lifecycle {
    ignore_changes = [
      color
    ]
  }
}

# Repository with branch ignore_changes
resource "github_repository" "branch_ignore" {
  name        = "branch-${var.environment}-repo"
  description = "Repository with branch ignore_changes configuration"
  visibility  = var.repo_visibility
  auto_init   = true
  
  # If branch was changed outside of Terraform, don't try to change it back
  lifecycle {
    ignore_changes = [
      default_branch
    ]
  }
}