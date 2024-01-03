# Terraform AWS Resources 

This Terraform configuration is used for aws code pipeline when it runs AWS vpc should be created.

## Prerequisites 

Before you begin, make sure you have the following:

1. **AWS Credentials and Configure**: Ensure you have AWS credentials configured with the necessary permissions to create resources.
2. clone this repo link on locally

   `git clone https://github.com/yahyagulshan/Terraform-AWS-code-pipeline/tree/aws-code-pipeline/terraform-run-with-aws-vpc`
3. **Manually created AWS code commit repo** We need to create aws code commit pipeline manually. after creating the aws code commit repo copy this repo link
   and clone locally here we already have a repo that cloned from the GitHub browser.

   Now use the below commands for push changes on the aws code commit.

`git config --local user.name "yahya-admin-at-960742198541"`

`git config --local user.email abc@gmail.com`

`git config --local init.defaultBranch main`

`git add test.tf`

`git commit -m "add new file test.tf"`

`git push origin main`
     ```

## Key Files 

 * `env_vars.tfvars`: Sample file for defining environment variables specific to the Terraform configuration.


