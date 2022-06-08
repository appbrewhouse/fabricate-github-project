terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.25.0-alpha"
    }
  }
}

provider "github" {
  token = var.git_token
  owner = var.org_name
}

# Team
resource "github_team" "app_team" {
  name        = "${var.app_name}-team"
  description = "Team for ${var.app_name}"
}

resource "github_membership" "info_user" {
  count    = length(var.collaborators_usernames)
  username = var.collaborators_usernames[count.index]
  role     = "admin"
}

resource "github_team_members" "app_team_members" {
  team_id = github_team.app_team.id

  count = length(var.collaborators_usernames)
  members {
    username = var.collaborators_usernames[count.index]
  }
}


module "apps" {
  source = "./modules/repository"

  providers = {
    github = github
  }

  for_each = var.apps_list

  git_token = var.git_token
  org_name  = var.org_name
  repo_name = "${var.app_name}-${each.key}"
  team_id   = github_team.app_team.id
}
