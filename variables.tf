variable "repo_name" {
  type    = string
  default = "video-repo"
}

variable "codebuild_project_name_validate" {
  type = string
  default = "demo-codebuild-validate"
}

variable "codebuild_project_name_plan" {
  type    = string
  default = "demo-codebuild-plan"
}



variable "codebuild_project_name_apply" {
  type = string
  default = "demo-codebuild-apply"
}

variable "codebuild_project1_name" {
  type    = string
  default = "demo-codebuild1"
}

# variable "repo_name" {
#   description = "The name of the CodeCommit repository (e.g. new-repo)."
#   default     = ""
# }

variable "repo_default_branch" {
  description = "The name of the default repository branch (default: master)"
  default     = "master"
}