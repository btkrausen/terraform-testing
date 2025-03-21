terraform {
  required_version = ">= 1.10.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Provider with full access token
provider "github" {
  alias = "full_access"
  # token = var.github_token_full  - disable for automated testing
}

# Provider with read-only token
provider "github" {
  alias = "read_only"
  # token = var.github_token_readonly - disable for automated testing
}