# Repository created with the full access provider
resource "github_repository" "full_access_repo" {
  provider    = github.full_access
  name        = var.repo_name
  description = "Repository created with full access token"
  visibility  = "public"
  auto_init   = true
}

# Add a README file using the full access provider
resource "github_repository_file" "readme" {
  provider            = github.full_access
  repository          = github_repository.full_access_repo.name
  branch              = "main"
  file                = "README.md"
  content             = "# Provider Demo Repo\n\nThis repos demonstrates Terraform provider configs with different auth tokens."
  commit_message      = "Add README"
  commit_author       = "Terraform"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

# This will work with the read-only token
data "github_repository" "read_only_repo" {
  provider = github.read_only
  name     = github_repository.full_access_repo.name
}