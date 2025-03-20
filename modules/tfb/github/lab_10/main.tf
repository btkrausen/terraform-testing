# Base Repository
resource "github_repository" "main" {
  name        = "terraform-${var.environment}-repo"
  description = "Terraform managed ${var.environment} repository"
  visibility  = var.repo_visibility
  auto_init   = true

  topics = ["terraform", "depends-on-demo"]
}

# Repository File
resource "github_repository_file" "readme" {
  repository          = github_repository.main.name
  branch              = var.default_branch
  file                = "README.md"
  content             = "# Terraform ${var.environment} Repository\n\nManaged by Terraform."
  commit_message      = "Add README"
  commit_author       = "Terraform"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

# Issue Label
resource "github_issue_label" "bug" {
  repository  = github_repository.main.name
  name        = "bug"
  color       = "FF0000"
  description = "Bug reports"
}

# Additional Repository Files with explicit dependency
resource "github_repository_file" "contributing" {
  repository          = github_repository.main.name
  branch              = var.default_branch
  file                = "CONTRIBUTING.md"
  content             = "# Contributing Guidelines\n\nThank you for your interest in contributing to this project."
  commit_message      = "Add CONTRIBUTING.md"
  commit_author       = "Terraform"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true

  # Explicitly depend on branch protection rule
  # This ensures the branch is protected before adding files
  depends_on = [github_repository.main]
}

# Additional Label with explicit dependency
resource "github_issue_label" "enhancement" {
  repository  = github_repository.main.name
  name        = "enhancement"
  color       = "00FF00"
  description = "Enhancement requests"

  # Explicitly depend on the first label and team access
  # This ensures labels are created in a specific order
  depends_on = [
    github_issue_label.bug
  ]
}