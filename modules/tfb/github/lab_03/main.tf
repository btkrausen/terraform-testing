# Create the repository
resource "github_repository" "example" {
  name        = var.repository_name
  description = "Repository created by Terraform"
  visibility  = var.repository_visibility

  auto_init = true

  has_issues      = var.repository_features.has_issues
  has_discussions = var.repository_features.has_discussions
  has_wiki        = var.repository_features.has_wiki

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true

  topics = ["terraform", "infrastructure-as-code", "learning"]
}

# Create branch protection rule
resource "github_branch_protection" "main" {
  repository_id = github_repository.example.node_id
  pattern       = "main"

  required_pull_request_reviews {
    required_approving_review_count = 2
  }
}