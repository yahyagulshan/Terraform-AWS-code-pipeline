# Terraform-AWS-code-pipeline
for creating the Terraform backend go into the/create-terraform-backend folder and follow the instructions as per README.md in there.

---
### Change in Make file
when we done with backend creation steps have Dynamodb table name and S3 bucket name need to replace these in line #7 and #8

---
### For Region change 
for change the region we need to replace the name of the directory /us-east-1

### Source code
in this article, we used AWS Code Commit as a  resource. we already created this directory named "video-repo"  . and created file there when the AWS Code Pipeline runs AWS VPC should be created.

### Pipeline
* in Source we create linux container.
* download Terraform on this linux container.
* then run the terraform  
* in aws code pipeline we first create stage for build
* 2nd build for validate
* 3rd build for plan
* 4th build for approve
* when our pipeline approched  to approve build sns send email for approval
* then we manually hit "approve" or "reject" button on AWS Code Pipeline
* if we hit "approve" the pipeline run further and complete the step or if we run "reject" the pipeline not running



