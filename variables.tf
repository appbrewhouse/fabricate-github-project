# Variables
variable "git_token" {
  description = "Personal access token for github account"
  type        = string
}

variable "org_name" {
  description = "Registered github organization name"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "collaborators_usernames" {
  description = "Collaborators you want to add to the repository"
  type        = list(string)
}

variable "apps_list" {
  description = "List of applications to create"
  type        = set(string)
}