output "repository_id" {
  description = "ID of the created repository"
  value       = github_repository.example.repo_id
}

output "repository_html_url" {
  description = "URL of the created repository"
  value       = github_repository.example.html_url
}

output "repository_git_clone_url" {
  description = "Git clone URL of the repository"
  value       = github_repository.example.git_clone_url
}

output "repository_visibility" {
  description = "Visibility of the repository"
  value       = github_repository.example.visibility
}