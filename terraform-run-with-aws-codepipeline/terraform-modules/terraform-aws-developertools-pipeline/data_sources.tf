##########################################
##  Data Source for AWS CodeCommit Repo ##
##########################################

data "aws_codecommit_repository" "repo" {
  repository_name = var.codecommit_repo_name
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
