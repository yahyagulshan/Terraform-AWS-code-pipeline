#############################################
##  AWS IAM Role for CodeBuild and Polices ##
#############################################

resource "aws_iam_role" "codebuild" {
  name               = "${var.codebuild_project_name}-codebuild-service-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild.json
}


data "aws_iam_policy_document" "codebuild" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  role       = aws_iam_role.codebuild.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

################################################
##  AWS IAM Role for CodePipeline and Polices ##
################################################

resource "aws_iam_role" "codepipeline" {
  name               = "${var.codebuild_project_name}-codepipeline-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codecommit" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}