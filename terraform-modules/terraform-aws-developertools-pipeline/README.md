# 🚀 Terraform AWS Developer Tools Pipeline 🚀

This Terraform configuration sets up a comprehensive AWS developer tools pipeline, including AWS CodeCommit, CodePipeline, CodeBuild, IAM roles, and S3 storage for artifacts.

Table of Contents
=================
   * [Prerequisites 🛠️](#prerequisites-️)
   * [Usage 📋](#usage-)
      * [<strong>Clone this repository to your local machine:</strong>](#clone-this-repository-to-your-local-machine)
      * [<strong>Add Terraform Backend Config and SNS topic ARN:</strong>](#add-terraform-backend-config-and-sns-topic-arn)
      * [<strong>Run Terraform and create AWS Pipeline Resources:</strong>](#run-terraform-and-create-aws-pipeline-resources)
   * [Directory Structure 📂](#directory-structure-)


## Prerequisites 🛠️

Before you begin, make sure you have the following:

1. **AWS Credentials and Configure**: Ensure you have AWS credentials configured with the necessary permissions to create resources.
2. **Terraform**: Install Terraform on your machine. Refer to the [official Terraform installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) for instructions.
3. **Create AWS CodeCommit Repository**: Create AWS CodeCommit Repo manually from AWS web Console as for now AWS CodeCommit Terraform provider currently doesn't support branch creation.
4. **Create Terraform Backend**: Go to the Terraform Backend directory and create the Terraform backend. Refer to the [Create Terraform Backend](../terraform-aws-backend) for instructions. Copy names of **s3 bucket** and **DynamoDB Table**
5. **AWS SNS topic and approval emails**: 
  * Configure an SNS topic: Create a topic specific to actions requiring approval (e.g., "terraform-approval"). Copy ARN of **SNS Topic**
  * Subscribe email addresses: Add relevant email addresses as subscribers to receive notifications.

## Usage 📋

### **Clone this repository to your local machine:**
   ```
     git clone codecommit::us-east-1://terraform-repo
     cd terraform-repo/terraform-modules/terraform-aws-developertools-pipeline/
  ```

### **Add Terraform Backend Config and SNS topic ARN:**
  * Open [backend.tf](./backend.tf) and add names of AWS S3 bucket name and AWS DynamDB table from output of Create Terraform Backend step
  * Open [env_vars.tfvars](./env_vars.tfvars) and add SNS topic ARN and AWS CodeCommit Repo Name, also change values according to requirements

### **Run Terraform and create AWS Pipeline Resources:**
  * `terraform init`
  * `terraform apply -var-file=env_vars.tfvars`

## Directory Structure 📂

  * `backend.tf`: Configuration for the Terraform backend, where state files are stored. Update this file if you want to change the backend configuration.

  * `codebuild.tf`: Terraform configuration for AWS CodeBuild, defining how the build process is executed. Modify this file to customize CodeBuild settings.

  * `codepipeline.tf`: Terraform configuration for AWS CodePipeline, defining the pipeline stages and actions. Customize this file for changes in the pipeline structure.

  * `data_sources.tf`: Contains Terraform data sources for retrieving information from existing AWS resources. Modify or add data sources based on your requirements.

  * `env_vars.tfvars`: Example file for setting environment variables used in the Terraform configuration. Update this file with your specific variable values.

  * `iam.tf`: Terraform configuration for IAM roles and policies. Modify this file to adjust IAM permissions as needed.

  * `README.md`: This file! Provides information about the repository, its purpose, and usage instructions.

  * `s3.tf`: Terraform configuration for S3 bucket settings. Update this file to adjust S3 bucket configurations.

  * `variables.tf`: Declares input variables used in various Terraform configurations. Modify this file to add or change variables.

```
├── terraform-modules
│   ├── terraform-aws-developertools-pipeline
│   │   ├── backend.tf
│   │   ├── codebuild.tf
│   │   ├── codepipeline.tf
│   │   ├── data_sources.tf
│   │   ├── env_vars.tfvars
│   │   ├── iam.tf
│   │   ├── README.md
│   │   ├── s3.tf
│   │   └── variables.tf

```