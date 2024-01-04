#############################################
##  AWS S3 Bucket for Codepipeline ##
#############################################

module "codepipeline_bucket" {
  source        = "../terraform-aws-s3-bucket"
  bucket        = "${var.codepipeline_name}-${random_uuid.s3.result}"
  force_destroy = true
}

resource "random_uuid" "s3" {}