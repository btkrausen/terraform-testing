terraform {
  required_version = ">= 1.10.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 5.5"
    }
  }
}

provider "github" {}