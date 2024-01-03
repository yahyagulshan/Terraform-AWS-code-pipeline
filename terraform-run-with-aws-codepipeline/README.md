# 🚀 Terraform AWS Resources 🚀

This Terraform configuration sets up  AWS reourses with AWS developer tools pipeline

Table of Contents
=================

   * [Prerequisites 🛠️](#prerequisites-️)
   * [Usage 📋](#usage-)
   * [Key Files 🛸](#key-files-)
   * [Directory Structure 📂](#directory-structure-)


## Prerequisites 🛠️

Before you begin, make sure you have the following:

1. **AWS Credentials and Configure**: Ensure you have AWS credentials configured with the necessary permissions to create resources.
2. **Create AWS CodeCommit Repository and setup**: Create AWS CodeCommit Repo manually from AWS web Console as for now AWS CodeCommit Terraform provider currently doesn't support branch creation.. We recommend that you use the latest versions of Git and other prerequisite software
   * Install Python and pip
   * Install and configure a Git client
   * Install git-remote-codecommit `pip install git-remote-codecommit`
   * Clone the repository:
     ```
     git clone codecommit::us-east-1://terraform-cicd
     cd terraform-cicd
     ```
3. **Terraform**: Install Terraform on your machine. Refer to the [official Terraform installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) for instructions.
4. **Create Terraform Backend**: Go to the Terraform Backend directory and create the Terraform backend. Refer to the [Create Terraform Backend](./terraform-modules/terraform-aws-backend) for instructionsand copy names of **s3 bucket** and **DynamoDB Table** from output
5. **Create AWS Pipeline**: Go to the Terraform Pipeline resources directory and create the pipeline resources. Refer to the [Terraform AWS DeveloperTools Pipeline](./terraform-modules/terraform-aws-developertools-pipeline) for instructions.

## Usage 📋

1. **Clone this repository to your local machine:**
     ```
       git clone codecommit::us-east-1://terraform-repo
       cd terraform-repo/
    ```

2. **Add Terraform Backend Config and SNS topic ARN:**
  * Open [backend.tf](./backend.tf) and add names of AWS S3 bucket name and AWS DynamDB table from output of Create Terraform Backend step
  * Open [env_vars.tfvars](./env_vars.tfvars) Add appopriate values
  * Push changes to `master` branch, AWS codepipeline will be trigger

## Key Files 🛸

* `main.tf`: The main Terraform configuration file where the AWS resources, including the SNS topic, are defined. Modify this file to customize the infrastructure according to your needs.

* `variables.tf`: This file declares the input variables used in the configuration. Update the variable values in the `env_vars.tfvars` file to match your requirements.  

* `env_vars.tfvars`: Sample file for defining environment variables specific to the Terraform configuration.

## Directory Structure 📂

  * `backend.tf`: Configures the backend for storing Terraform state remotely.

  * `data_sources.tf`: Defines Terraform data sources to fetch information from existing resources.

  * `locals.tf`: Declares local variables used within the Terraform configuration.

  * `terraform-modules/`: Directory containing reusable Terraform modules.

  * `main.tf`: Defines the main infrastructure components.

  * `buildspec-templates/`: Directory containing templates for AWS CodeBuild build specifications.

  * `env_vars.tfvars`: Sample file for defining environment variables specific to the Terraform configuration.

  * `README.md`: The file you are currently reading, providing instructions and details about the repository.

  * `variables.tf`: Declares input variables used in the main Terraform configuration.
