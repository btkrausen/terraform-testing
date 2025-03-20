# Refactored Repository Resources using count
resource "github_repository" "repo" {
  count       = var.repo_count
  name        = var.repo_names[count.index]
  description = "Example repository ${count.index + 1}"
  visibility  = "public"
  auto_init   = true

  topics = ["example", "terraform", "repo${count.index + 1}"]
}

# Refactored Branch Protection resources using count
resource "github_branch_protection" "protection" {
  count         = var.repo_count
  repository_id = github_repository.repo[count.index].node_id
  pattern       = "main"

  allows_deletions                = false
  allows_force_pushes             = false
  require_conversation_resolution = true
}

# Create multiple README files
resource "github_repository_file" "readme" {
  count               = var.readme_count
  repository          = github_repository.repo[count.index].name
  branch              = "main"
  file                = "README.md"
  content             = "# Repository ${count.index + 1}\nThis is an example repository created with Terraform count."
  commit_message      = "Add README"
  commit_author       = "Terraform"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}