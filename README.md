## Prerequisites 

Before you begin, make sure you have the following:

1. **AWS Credentials and Configure**: Ensure you have AWS credentials configured with the necessary permissions to create resources.
2. **Create AWS CodeCommit Repository and setup**: Create AWS CodeCommit Repo manually from AWS web Console .
3. **Terraform**: Install Terraform on your machine. Refer to the [official Terraform installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) for instructions.
---
---
`this step is extra here for good practise of backend`

4. **Create Terraform Backend**: Go to the Terraform Backend directory and create the Terraform backend. **DynamoDB Table** from output
---
---
5. **Create SNS**: manually create AWS SNS topin on AWS and its subscription for notifying.

6. **Create AWS Pipeline**: for pipeline clone this repo on your local and run command

`terraform init`

`terraform plan`

when we run `terraform plan` command  terraform state file created on our local 

now go for terraform apply
`terraform apply`
## Usage 

## Key Files 

* `variables.tf`: this file have the value of "repo-name", "code-build-project", "default_branch"
* `S3.tf`: this file have S3 bucket name

## for create code commit repo on aws follow `terraform-run-with-aws-vpc` folder which are place in this directory

![Screenshot from 2024-01-04 02-08-46](https://github.com/yahyagulshan/Terraform-AWS-code-pipeline/assets/59036269/fe0bda00-fcb6-463d-8b68-00978dfb2bb7)



