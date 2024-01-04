############################################
##  Common Variables
############################################
variable "region" {
  description = "AWS Region for this stack"
  type        = string
  default     = "us-east-1"
}

variable "stack_name" {
  description = "Stack Name (ie: Prod1, CS1P, QA01, DepTest03, etc.)"
  type        = string
  default = "Prod1"
}

variable "environment" {
  description = "Environment identifier for VPC and TGW Name tags"
  type        = string
  default = "prod"
}

variable "company" {
  type        = string
  description = "Company identifier to use for naming"
  default = "test"
}

############################################
##  Tag Variables
############################################

variable "common_tags" {
  description = "Tags that should be applied to all tagable resources"
  type        = map(any)
  default     = {}
}

variable "application" {
  description = "Value to apply to the Application tag on all tagable resources"
  type        = string
  default = "DevOps"
}

variable "owner" {
  description = "The owner of this resource (Requester/Department/Responsible Party)"
  type        = string
  default = "Infrastructure/DevOps"
}

variable "purpose" {
  description = "Why is this resource being created?"
  type        = string
  default = "test Terraform Pipeline resources"
}
# End standard tag values

############################################
##  AWS developer Tools Tags
############################################

variable "codecommit_repo_name" {
  type = string
  default = "video-repo"
}

variable "codebuild_project_name" {
  type = string
  default = "terraform-build"
}

variable "codepipeline_name" {
  type = string
  default = "terraform-pipeline"
}

variable "approve_sns_arn" {
  type = string
  default = "arn:aws:sns:us-east-1:960742198541:terraform-plan-ready"
}


variable "builder_compute_type" {
  description = "Relative path to the Apply and Destroy build spec file"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "builder_image" {
  description = "Docker Image to be used by codebuild"
  type        = string
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
}

variable "builder_type" {
  description = "Type of codebuild run environment"
  type        = string
  default     = "LINUX_CONTAINER"
}

variable "builder_image_pull_credentials_type" {
  description = "Image pull credentials type used by codebuild project"
  type        = string
  default     = "CODEBUILD"
}


variable "build_project_source" {
  description = "CodeBuild project source type"
  type        = string
  default     = "CODECOMMIT"
}

variable "build_project_artifacts" {
  description = "CodeBuild project artifacts type"
  type        = string
  default     = "NO_ARTIFACTS"
}

variable "build_project_source_version" {
  description = "CodeBuild project artifacts type"
  type        = string
  default     = "NO_ARTIFACTS"
}


variable "codepipe_project_owner" {
  description = "CodePipeline project Owner"
  type        = string
  default     = "AWS"
}


variable "codepipe_project_version" {
  description = "CodePipeline project Version"
  type        = string
  default     = "1"
}

variable "codepipe_project_artifacts" {
  description = "CodePipeline project artifacts"
  type        = string
  default     = "source_artifact"
}

variable "codepipe_project_provider" {
  description = "CodePipeline project provider "
  type        = string
  default     = "CodeBuild"
}


variable "codepipe_project_category" {
  description = "CodePipeline project provider "
  type        = string
  default     = "Build"
}