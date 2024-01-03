
###########################################
##  AWS CodeBuild Projects Configuration ##
###########################################

resource "aws_codebuild_project" "terraform-validate" {
  name         = "${var.codebuild_project_name}-validate"
  service_role = aws_iam_role.codebuild.arn
  environment {
    compute_type = var.builder_compute_type
    image        = var.builder_image
    type         = var.builder_type
    image_pull_credentials_type = var.builder_image_pull_credentials_type
  }
  source {
    type            = var.build_project_source
    location        = data.aws_codecommit_repository.repo.clone_url_http
    git_clone_depth = 1
    buildspec       = "./buildspec-templates/buildspec_validate.yml"
  }
  artifacts {
    type = var.build_project_artifacts
  }
  source_version = var.build_project_source_version
}


###########################################
##  AWS CodeBuild Projects Configuration ##
###########################################

resource "aws_codebuild_project" "terraform-plan" {
  name         = "${var.codebuild_project_name}-plan"
  service_role = aws_iam_role.codebuild.arn
  environment {
    compute_type = var.builder_compute_type
    image        = var.builder_image
    type         = var.builder_type
    image_pull_credentials_type = var.builder_image_pull_credentials_type
  }
  source {
    type            = var.build_project_source
    location        = data.aws_codecommit_repository.repo.clone_url_http
    git_clone_depth = 1
    buildspec       = "./buildspec-templates/buildspec_plan.yml"
  }
  artifacts {
    type = var.build_project_artifacts
  }
  source_version = var.build_project_source_version
}

###########################################
##  AWS CodeBuild Projects Configuration ##
###########################################

resource "aws_codebuild_project" "terraform-apply" {
  name         = "${var.codebuild_project_name}-apply"
  service_role = aws_iam_role.codebuild.arn
  environment {
    compute_type = var.builder_compute_type
    image        = var.builder_image
    type         = var.builder_type
    image_pull_credentials_type = var.builder_image_pull_credentials_type
  }
  source {
    type            = var.build_project_source
    location        = data.aws_codecommit_repository.repo.clone_url_http
    git_clone_depth = 1
    buildspec       = "./buildspec-templates/buildspec_apply.yml"
  }
  artifacts {
    type = var.build_project_artifacts
  }
  source_version = var.build_project_source_version
}

###########################################
##  AWS CodeBuild Projects Configuration ##
###########################################

resource "aws_codebuild_project" "terraform-destroy" {
  name         = "${var.codebuild_project_name}-destroy"
  service_role = aws_iam_role.codebuild.arn
  environment {
    compute_type = var.builder_compute_type
    image        = var.builder_image
    type         = var.builder_type
    image_pull_credentials_type = var.builder_image_pull_credentials_type
  }
  source {
    type            = var.build_project_source
    location        = data.aws_codecommit_repository.repo.clone_url_http
    git_clone_depth = 1
    buildspec       = "./buildspec-templates/buildspec_destroy.yml"
  }
  artifacts {
    type = var.build_project_artifacts
  }
  source_version = var.build_project_source_version
}