# Repositories created with count
resource "github_repository" "repo_count" {
  count       = 3
  name        = "repo-count-${count.index + 1}"
  description = "Repository ${count.index + 1} created with count"
  visibility  = "public"
  auto_init   = true

  topics = ["terraform", "count", "example"]
}

# Branch protection rules created with count
resource "github_branch_protection" "protection_count" {
  count         = 3
  repository_id = github_repository.repo_count[count.index].node_id
  pattern       = "main"

  allows_deletions                = false
  allows_force_pushes             = false
  require_conversation_resolution = true
}

# Issue labels created with count
resource "github_issue_label" "label_count" {
  count       = 6 # 2 labels for each of 3 repos
  repository  = github_repository.repo_count[count.index % 3].name
  name        = count.index < 3 ? "bug" : "feature"
  color       = count.index < 3 ? "FF0000" : "00FF00"
  description = count.index < 3 ? "Bug issues" : "Feature requests"
}

# Repositories created with for_each
resource "github_repository" "repo_foreach" {
  for_each    = var.repositories
  name        = "repo-${each.key}"
  description = each.value
  visibility  = "public"
  auto_init   = true

  topics = ["terraform", "foreach", "example"]
}

# Branch protection rules created with for_each
resource "github_branch_protection" "protection_api" {
  for_each      = var.branch_patterns
  repository_id = github_repository.repo_foreach["api"].node_id
  pattern       = each.key

  allows_deletions                = false
  allows_force_pushes             = false
  require_conversation_resolution = true
}

resource "github_branch_protection" "protection_web" {
  for_each      = var.branch_patterns
  repository_id = github_repository.repo_foreach["web"].node_id
  pattern       = each.key

  allows_deletions                = false
  allows_force_pushes             = false
  require_conversation_resolution = true
}

# Issue labels for API repository
resource "github_issue_label" "label_api" {
  for_each    = var.label_config
  repository  = github_repository.repo_foreach["api"].name
  name        = each.key
  color       = each.value
  description = "${each.key} label for API repository"
}

# Issue labels for Web repository
resource "github_issue_label" "label_web" {
  for_each    = var.label_config
  repository  = github_repository.repo_foreach["web"].name
  name        = each.key
  color       = each.value
  description = "${each.key} label for Web repository"
}

# Repository files created with for_each
resource "github_repository_file" "api_files" {
  for_each            = var.repo_files
  repository          = github_repository.repo_foreach["api"].name
  branch              = "main"
  file                = each.key
  content             = each.value
  commit_message      = "Add ${each.key}"
  commit_author       = "Terraform"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}