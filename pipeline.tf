
data "aws_codecommit_repository" "repo" {
  repository_name = var.repo_name
}
resource "aws_codebuild_project" "validate" {
  name         = var.codebuild_project_name_validate
  service_role = aws_iam_role.example.arn
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type            = "CODECOMMIT"
    location        = data.aws_codecommit_repository.repo.clone_url_http
        # location        = "aws_codecommit_repository.repo"
    git_clone_depth = 1
    buildspec       = <<-EOF
      version: 0.2
      phases:
        build:
          commands:
            - sudo yum update -y
            - sudo yum install -y unzip
            - curl -O https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip
            - unzip terraform_0.15.4_linux_amd64.zip
            - sudo mv terraform /usr/local/bin/
            - terraform version
            - terraform init
            - terraform validate
   
    EOF  
  }
  
  artifacts {
    type = "NO_ARTIFACTS"
  }
  source_version = "main"
}

########### 2nd build ####################
resource "aws_codebuild_project" "plan" {
  name         = var.codebuild_project_name_plan
  service_role = aws_iam_role.example.arn
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type            = "CODECOMMIT"
    location        = data.aws_codecommit_repository.repo.clone_url_http
        # location        = "aws_codecommit_repository.repo"
    git_clone_depth = 1
    buildspec       = <<-EOF
      version: 0.2
      phases:
        build:
          commands:
            - sudo yum update -y
            - sudo yum install -y unzip
            - curl -O https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip
            - unzip terraform_0.15.4_linux_amd64.zip
            - sudo mv terraform /usr/local/bin/
            - terraform version
            - terraform init

            - terraform plan
            # - terraform apply --auto-approve   
    EOF  
  }
  
  artifacts {
    type = "NO_ARTIFACTS"
  }
  source_version = "main"
}


########### 3rd build ####################
resource "aws_codebuild_project" "apply" {
  name         = var.codebuild_project_name_apply
  service_role = aws_iam_role.example.arn
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type            = "CODECOMMIT"
    location        = data.aws_codecommit_repository.repo.clone_url_http
        # location        = "aws_codecommit_repository.repo"
    git_clone_depth = 1
    buildspec       = <<-EOF
      version: 0.2
      phases:
        build:
          commands:
             - sudo yum update -y
             - sudo yum install -y unzip
             - curl -O https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip
             - unzip terraform_0.15.4_linux_amd64.zip
             - sudo mv terraform /usr/local/bin/
             - terraform version
             - terraform init
             - terraform validate
             - terraform plan
             - terraform apply --auto-approve   
    EOF  
  }
  
  artifacts {
    type = "NO_ARTIFACTS"
  }
  source_version = "main"
}


resource "aws_codepipeline" "example" {
  name = "terraform-pipeline"

  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.example_bucket.id
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name     = "SourceAction"
      category = "Source"
      owner    = "AWS"
      provider = "CodeCommit"
      version  = "1"
      configuration = {
        RepositoryName = var.repo_name
        BranchName     = "main"
      }

      output_artifacts = ["source_artifact"]
    }
  }

  stage {
    name = "validate"

    action {
      name            = "Terraform-validate"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_artifact"]
      configuration = {
        ProjectName = aws_codebuild_project.validate.name
      }
    }
  }   

    stage {
    name = "plan"

    action {
      name            = "Terraform-plan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_artifact"]
      configuration = {
        ProjectName = aws_codebuild_project.plan.name
      }
    }
  }

  stage {
  name = "Approve"

  action {
    name     = "Terraform-apply-Approval"
    category = "Approval"
    owner    = "AWS"
    provider = "Manual"
    version  = "1"

    configuration = {
      NotificationArn = "arn:aws:sns:us-east-1:960742198541:terraform-plan-ready"
      # CustomData = "${var.approve_comment}"
      # ExternalEntityLink = "${var.approve_url}"
    }
  }
}


      stage {
    name = "apply"

    action {
      name            = "Terraform-apply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_artifact"]
      configuration = {
        ProjectName = aws_codebuild_project.apply.name
      }
    }
  }

}

########## new changes for vpc cloudformation ############
resource "aws_iam_role" "codepipeline" {
  name = "YourCodePipelineRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "cloudformation_execution_role" {
  name = "YourCloudFormationExecutionRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "cloudformation.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

######### new changes add for sns ##############

data "aws_sns_topic" "example" {
  name = "terraform-plan-ready"
}


###############################################






