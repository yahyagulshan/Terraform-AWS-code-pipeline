this Terraform configuration sets up AWS resource with AWS developer tools pipeline

## Prerequisites

1- Configure AWS credentials with necessery permission.

2- Create AWS Code Commit Repository

3- Install Terraform on local system

4- Create Terraform backend using [Create Terraform Backend](./terraform-modules/terraform-aws-backend)

5- Create AWS Pipeline resources with using this [Create AWS Pipeline](./terraform-modules/terraform-aws-developertools-pipeline)

## Usage

### Add Terraform Backend Config and SNS topic ARN:

* Open `backend.tf` and add names of AWS S3 bucket name and AWS DynamDB table from output of Create Terraform Backend step
* Open `env_vars.tfvars` Add appopriate values

## key files

* `variables.tf:` This file declares the input variables used in the configuration. Update the variable values in the `env_vars.tfvars` file to match your requirements

* `env_vars.tfvars:` Sample file for defining environment variables specific to the Terraform configuration.

## Directory Structure

* `backend.tf:` Configures the backend for storing Terraform state remotely.

* `data_sources.tf:` Defines Terraform data sources to fetch information from existing resources.

* `locals.tf:` Declares local variables used within the Terraform configuration.

* `terraform-modules/:` Directory containing reusable Terraform modules.

* `main.tf:` Defines the main infrastructure components.

* `buildspec-templates/:` Directory containing templates for AWS CodeBuild build specifications.

* `env_vars.tfvars:` Sample file for defining environment variables specific to the Terraform configuration.

* `README.md:` The file you are currently reading, providing instructions and details about the repository.

* `variables.tf:` Declares input variables used in the main Terraform configuration.
