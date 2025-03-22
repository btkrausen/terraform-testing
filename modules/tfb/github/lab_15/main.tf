# Add resources for the lab below
# Create repositories using the github_repository module
module "api_repository" {
  source      = "./modules/github_repository"
  name        = "api-${var.environment}"
  description = "API service repository"
  visibility  = "public"

  has_issues   = true
  has_projects = true
  has_wiki     = true
  auto_init    = true

  gitignore_template = "Node"
  license_template   = "mit"

  topics = ["api", "service", var.environment]
}

module "frontend_repository" {
  source      = "./modules/github_repository"
  name        = "frontend-${var.environment}"
  description = "Frontend application repository"
  visibility  = "public"

  has_issues   = true
  has_projects = true
  has_wiki     = false
  auto_init    = true

  gitignore_template = "Node"
  license_template   = "mit"

  topics = ["frontend", "react", var.environment]
}

# Apply branch protection rules using the branch_protection module
module "api_branch_protection" {
  source          = "./modules/branch_protection"
  repository_name = module.api_repository.name
  branch          = "main"

  enforce_admins         = true
  require_signed_commits = false

  required_status_checks = {
    strict   = true
    contexts = ["ci/github-actions"]
  }

  required_pull_request_reviews = {
    dismiss_stale_reviews           = true
    restrict_dismissals             = false
    require_code_owner_reviews      = true
    required_approving_review_count = 1
    dismissal_restrictions          = []
  }

  allows_deletions    = false
  allows_force_pushes = false
}

module "frontend_branch_protection" {
  source          = "./modules/branch_protection"
  repository_name = module.frontend_repository.name
  branch          = "main"

  enforce_admins         = true
  require_signed_commits = false

  required_status_checks = {
    strict   = true
    contexts = ["ci/github-actions"]
  }

  required_pull_request_reviews = {
    dismiss_stale_reviews           = true
    restrict_dismissals             = false
    require_code_owner_reviews      = true
    required_approving_review_count = 1
    dismissal_restrictions          = []
  }

  allows_deletions    = false
  allows_force_pushes = false
}