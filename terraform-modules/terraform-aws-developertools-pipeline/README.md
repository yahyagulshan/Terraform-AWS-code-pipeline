This Terraform configuration sets up a comprehensive AWS developer tools pipeline, including AWS CodeCommit, CodePipeline, CodeBuild, IAM roles, and S3 storage for artifacts.

## Prerequisites

before you begin, make sure you have the following:

1- AWS Credentials and Configure: Ensure you have AWS credentials configured with the necessary permissions to create resources.

2- Terraform: Install Terraform on your machine. Refer to the official Terraform installation guide for instructions.

3- Create AWS CodeCommit Repository: Create AWS CodeCommit Repo manually from AWS web Console as for now AWS CodeCommit Terraform provider currently doesn't support branch creation.

4- AWS SNS topic and approval emails:

* Configure an SNS topic: Create a topic specific to actions requiring approval (e.g., "terraform-approval"). Copy ARN of SNS Topic

* Subscribe email addresses: Add relevant email addresses as subscribers to receive notifications.


## Usage

Clone this repository to your local machine:

git clone https://github.com/yahyagulshan/Terraform-AWS-code-pipeline.git/terraform-modules/terraform-aws-developertools-pipeline

### Add SNS ARN:

* open `pipeline.tf` file and add SNS name in line # `260` 
* open `variables.tf` file and add the name `repo-name` , `codebuild_project` , and `branch-name`

## Directory Structure

* `variables.tf:` Declares input variables used in various Terraform configurations. Modify this file to add or change variables.

* `s3.tf:`  Terraform configuration for S3 bucket settings. Update this file to adjust S3 bucket configurations.

* `codepipeline.tf:` Terraform configuration for AWS CodePipeline, codebuild defining the pipeline stages and actions. Customize this file for changes in the pipeline structure.

* `iam.tf:` Terraform configuration for IAM roles and policies. Modify this file to adjust IAM permissions as needed.

* `provider.tf:` terraform version and AWS Region is defined there.

* `README.md:` This file! Provides information about the repository, its purpose, and usage instructions.
