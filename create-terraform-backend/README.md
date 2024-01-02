# create-terrform-backend

Created the infrastructure for a terraform backend to store state files in s3

## Usage

The script requires that you pass in your own credentials to make this work

### Script parameters

| Flag  | Description                                                              | Required |
| :---: | ------------------------------------------------------------------------ | :------: |
| a     | This is the account name. Generally the account name. (i.e. dev or prod) | true     |
| d     | The default region where the terraform resources go                      | true     |
| r     | The region where the s3 bucket for terraform is replicated               | true     |
| o     | The name of AWS account owner/client                                     | true     |

### Usage with an AWS profile

```
AWS_PROFILE=example ./create-terraform-backend.sh -a dev -d us-east-1 -r us-east-2 -o devops01
```

### Usage with AWS environment keys

```
export AWS_ACCESS_KEY_ID="<access_key>"
export AWS_SECRET_ACCESS_KEY="<secret Key>"
export AWS_SESSION_TOKEN="<session token>"

./create-terraform-backend.sh -a dev -d us-east-1 -r us-east-2 -o devops01
```
