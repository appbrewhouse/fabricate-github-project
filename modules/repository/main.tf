terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.25.0-alpha"
    }
  }
}

resource "github_repository" "repo" {
  name         = var.repo_name
  description  = var.repo_name
  visibility   = "private"
  has_issues   = true
  has_projects = true
  auto_init    = true
}

resource "github_repository_file" "intial_readme" {
  repository          = github_repository.repo.name
  file                = "README.md"
  content             = "# ${var.repo_name}"
  commit_message      = "Initial commit"
  overwrite_on_create = true
}

resource "github_team_repository" "team_repo" {
  team_id    = var.team_id
  repository = github_repository.repo.name
  permission = "admin"
}

resource "github_repository_project" "project" {
  name       = "A github project for ${var.repo_name} repository"
  repository = github_repository.repo.name
}

resource "github_branch" "development" {
  repository = github_repository.repo.name
  branch     = "development"
}

resource "github_branch" "staging" {
  repository = github_repository.repo.name
  branch     = "staging"
}

resource "github_branch" "production" {
  repository = github_repository.repo.name
  branch     = "production"
}

resource "github_branch_default" "default" {
  repository = github_repository.repo.name
  branch     = github_branch.development.branch
}
