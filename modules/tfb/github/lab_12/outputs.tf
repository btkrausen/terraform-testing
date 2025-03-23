output "standard_repository_url" {
  description = "URL of the standard repository"
  value       = github_repository.standard.html_url
}

output "protected_repository_url" {
  description = "URL of the protected repository"
  value       = github_repository.protected.html_url
}

output "branch_ignore_repository_url" {
  description = "URL of the repository with branch ignore_changes"
  value       = github_repository.branch_ignore.html_url
}

output "lifecycle_examples" {
  description = "Examples of lifecycle configurations used"
  value = {
    "prevent_destroy" = "Repository protected from accidental deletion"
    "ignore_changes"  = "Issue color and repository branch changes are ignored"
  }
}