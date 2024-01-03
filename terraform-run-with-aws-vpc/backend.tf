##########################################
##  AWS terraform Remote Backend Config ##
##########################################

terraform {
  backend "s3" {
    region         = "us-east-1"
    key            = "prod/terraform.tfstate"
    bucket         = "whp-mission-prod-terraform-backend-us-east-1"
    dynamodb_table = "terraform-backend.lock"
    encrypt        = true
  }

  required_version = ">= 1.0.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

####################################
##  AWS terraform Provider Config ##
####################################

provider "aws" {

  region = var.region

  default_tags {
    tags = {
      Application = "${var.application}"
      Owner       = "${var.owner}"
      Purpose     = "${var.purpose}"
      Stack       = "${var.stack_name}"
      Terraform   = "true"
      Environment = "${var.environment}"
    }
  }

}
