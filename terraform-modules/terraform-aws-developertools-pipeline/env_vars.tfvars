##########################
## Tag Values Variables ##
##########################

owner       = "Infrastructure/DevOps"
purpose     = "test Terraform Pipeline resources"
application = "DevOps"
stack_name  = "terraform-pipeline"
company     = "test"
environment = "prod"

##################################
## Terraform Pipeline Variables ##
##################################

codebuild_project_name = "terraform-build"
codecommit_repo_name   = "terraform-cicd"
codepipeline_name      = "terraform-pipeline"
approve_sns_arn        = "arn:aws:sns:us-east-1:960742198541:terraform-plan-ready"