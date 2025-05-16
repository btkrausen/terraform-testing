# GitHub Repository
resource "github_repository" "example" {
  name        = "${var.prefix}-repo-${random_string.suffix.result}"
  description = var.repository_description
  visibility  = var.repository_visibility
  
  auto_init          = var.auto_init
  gitignore_template = var.gitignore_template
  topics             = var.repository_topics
}

# GitHub Branch
resource "github_branch" "development" {
  repository = github_repository.example.name
  branch     = "development"
}

# Branch Protection
resource "github_branch_protection" "main" {
  repository_id = github_repository.example.node_id
  pattern       = "main"
  
  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }
}

# Repository File
resource "github_repository_file" "readme" {
  repository          = github_repository.example.name
  branch              = "main"
  file                = "README.md"
  content             = "# ${github_repository.example.name}\n\n${var.repository_description}\n"
  commit_message      = "Update README"
  commit_author       = "Terraform"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

# Random string for resource name uniqueness
resource "random_string" "suffix" {
  length  = var.random_suffix_length
  special = var.special_chars_allowed
  upper   = var.upper_chars_allowed
}