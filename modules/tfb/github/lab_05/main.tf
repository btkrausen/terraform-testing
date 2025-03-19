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

# Create development repository
resource "github_repository" "development" {
  name        = var.dev_repository_name
  description = "Primary Dev Repo for new apps"
  visibility  = "public"

  auto_init = true

  has_issues      = var.dev_repo_issues
  has_discussions = var.dev_discussions
  has_wiki        = var.dev_wiki

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true

  topics = ["terraform", "infrastructure-as-code"]
}

resource "github_branch_protection" "development" {
  repository_id = github_repository.development.node_id
  pattern       = "main"
}

resource "github_branch" "development" {
  repository = github_repository.development.name
  branch     = "main"
}

resource "github_branch_default" "development" {
  repository = github_repository.development.name
  branch     = github_branch.development.branch
}

# Repository Files
resource "github_repository_file" "development" {
  repository          = github_repository.development.name
  branch              = github_branch.development.branch
  file                = ".gitignore"
  content             = "**/*.tfstate"
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@course.com"
  overwrite_on_create = true
}

# Create production repository
resource "github_repository" "production" {
  name        = var.prod_repository_name
  description = "Production repository managed by Terraform"
  visibility  = "public"

  auto_init = true

  has_issues      = true
  has_discussions = false
  has_wiki        = false

  vulnerability_alerts = true

  topics = ["terraform", "production"]
}

# Create stricter branch protection for production
resource "github_branch_protection" "production" {
  repository_id = github_repository.production.node_id
  pattern       = "main"

  enforce_admins = true

  required_pull_request_reviews {
    required_approving_review_count = var.prod_branch_protection
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
  }

  require_signed_commits = true
}

# Create a production environment
resource "github_repository_environment" "production" {
  repository  = github_repository.production.name
  environment = "production"

  reviewers {
    users = [data.github_user.current.id]
  }

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}

# Create a README file that references all repositories
resource "github_repository_file" "production_readme" {
  repository          = github_repository.production.name
  branch              = "main"
  file                = "README.md"
  content             = <<-EOT
    # Production Repository
    
    This repository is managed by Terraform.
    
    ## Related Repositories
    
    - Development: [${github_repository.development.name}](${github_repository.development.html_url})
    - Example: [${github_repository.example.name}](${github_repository.example.html_url})
  EOT
  commit_message      = "Add README via Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@course.com"
  overwrite_on_create = true
}