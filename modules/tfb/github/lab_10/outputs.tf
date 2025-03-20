output "repository_name" {
  description = "Name of the GitHub repository"
  value       = github_repository.main.name
}

output "repository_url" {
  description = "URL of the GitHub repository"
  value       = github_repository.main.html_url
}

output "files_created" {
  description = "Files created in the repository"
  value = [
    github_repository_file.readme.file,
    github_repository_file.contributing.file
  ]
}

output "dependency_example" {
  description = "Example of dependencies in this lab"
  value = {
    "Implicit dependencies" = "Repository -> Repository File, Repository -> Issue Label, Team -> Team Repository Access"
    "Explicit dependencies" = "Label/Team Access -> Enhancement Label, Files"
  }
}