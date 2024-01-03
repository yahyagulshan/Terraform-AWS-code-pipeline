# 🚀 Create Terraform Backend: S3 and DynamoDB with CloudFormation 🚀

Created the infrastructure for a Terraform backend to store state files in S3 and DynamoDB via CloudFormation.

Table of Contents
=================

   * [Prerequisites 🛠️](#prerequisites-️)
   * [Usage 📋](#usage-)
      * [Script Parameters 🎯](#script-parameters-)
      * [Usage with an AWS Profile 🔄](#usage-with-an-aws-profile-)
      * [Usage with AWS environment keys  🔑](#usage-with-aws-environment-keys--)
   * [Directory Structure 📂](#directory-structure-)


## Prerequisites 🛠️

Before proceeding, make sure you have the following:

* AWS account: You'll need an active AWS account with appropriate permissions.
* AWS CLI: Install and configure the AWS Command Line Interface to interact with AWS services. https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
* AWS credentials: Set up your AWS credentials using a profile or environment keys.

## Usage 📋

The script requires your AWS credentials to work.

### Script Parameters 🎯


| Flag  | Description                                                              | Required |
| :---: | ------------------------------------------------------------------------ | :------: |
| a     | This is the account name. Generally the account name. (i.e. dev or prod) | true     |
| d     | The default region where the terraform resources go                      | true     |
| r     | The region where the s3 bucket for terraform is replicated               | true     |
| o     | The name of AWS account owner/client                                     | true     |

### Usage with an AWS Profile 🔄

```
AWS_PROFILE=example ./create-terraform-backend.sh -a dev-d us-east-1 -r us-east-2 -o test
```

### Usage with AWS environment keys  🔑

```
export AWS_ACCESS_KEY_ID="<access_key>"
export AWS_SECRET_ACCESS_KEY="<secret Key>"
export AWS_SESSION_TOKEN="<session token>"

aws configure --profile test
export AWS_PROFILE=test
aws sts get-caller-identity

./create-terraform-backend.sh -a prod -d us-east-1 -r us-west-2 -o test
```

Output
Upon successful execution, you'll see the following output:

```
Terraform S3 Bucket Arn: ...
Terraform S3 Bucket Name: ...
Terraform DynamoDB Table Arn: ...
Terraform DynamoDB Table Name: ...
Terraform KMS ARN: ...
Terraform backend complete  ✨
```

Copy the S3 bucket name and DynamoDB table name to use in your Terraform backend config.

Ready to Rock!
Now you're all set to create and manage your Terraform state with confidence! ️

## Directory Structure 📂

  * `create-terraform-backend.sh`: A script to create a Terraform backend with S3 and DynamoDB.
  * `destination-region.yml`: YAML configuration for the destination AWS region.
  * `README.md`: This file, providing instructions and details about the project.
  * `source-region.yml`: YAML configuration for the source AWS region.

```
├── terraform-modules
│   ├── terraform-aws-backend
│   │   ├── create-terraform-backend.sh
│   │   ├── destination-region.yml
│   │   ├── README.md
│   │   └── source-region.yml

```