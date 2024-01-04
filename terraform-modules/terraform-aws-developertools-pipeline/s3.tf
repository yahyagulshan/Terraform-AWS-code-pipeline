resource "aws_s3_bucket" "example_bucket" {
  bucket = "pipeline-artifact-terraform-pipeline-123654"
  acl    = "private" # Access Control List (ACL) for the bucket
  force_destroy = true
}