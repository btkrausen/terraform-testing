output "repo_count_urls" {
  description = "URLs of count-based repositories"
  value       = github_repository.repo_count
}

output "repo_foreach_urls" {
  description = "URLs of for_each-based repositories"
  value       = github_repository.repo_foreach
}

output "branch_protection_api" {
  description = "Branch protection rules for API repository"
  value       = github_repository_file.api_files
}

output "label_api" {
  description = "Labels for API repository"
  value       = github_issue_label.label_api
}