output "repo_id" {
  description = "ID of the repository"
  value       = github_repository.this.repo_id
}

output "full_name" {
  description = "Full name of the repository"
  value       = github_repository.this.full_name
}

output "html_url" {
  description = "HTML URL of the repository"
  value       = github_repository.this.html_url
}

output "ssh_clone_url" {
  description = "SSH clone URL of the repository"
  value       = github_repository.this.ssh_clone_url
}

output "git_clone_url" {
  description = "Git clone URL of the repository"
  value       = github_repository.this.git_clone_url
}

output "name" {
  description = "Name of the repository"
  value       = github_repository.this.name
}