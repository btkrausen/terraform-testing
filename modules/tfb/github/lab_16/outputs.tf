output "repository_name" {
  description = "Name of the created repository"
  value       = github_repository.example.name
}

output "repository_url" {
  description = "URL of the created repository"
  value       = github_repository.example.html_url
}

output "development_branch" {
  description = "Name of the development branch"
  value       = github_branch.development.branch
}