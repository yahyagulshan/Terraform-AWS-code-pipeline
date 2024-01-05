#!/bin/bash
set -e

# To run this script, you will need to pass the crednetials via env vars

export AWS_PAGER=""
export CF_FAILED_STATUSES="CREATE_FAILED ROLLBACK_COMPLETE ROLLBACK_FAILED UPDATE_ROLLBACK_COMPLETE"
export CF_SUCCESS_STATUSES="CREATE_COMPLETE UPDATE_COMPLETE"

export APPLICATION="terraform"
export COMPONENT="backend"
# export COMPONENT="backend-prod"

export CF_STACK_NAME="${APPLICATION}-${COMPONENT}"

while getopts a:d:o:r: flag
do
  case "${flag}" in
    a) ACCOUNT_NAME=${OPTARG};;
    d) AWS_DEFAULT_REGION=${OPTARG};;
    o) OWNER_NAME=${OPTARG};;
    r) AWS_REPLICATION_REGION=${OPTARG};;
  esac
done

# make sure flags are passed in
if [[ $ACCOUNT_NAME == '' ]]
then
  echo "-a ACCOUNT_NAME required"
  exit 1;
fi
if [[ $AWS_DEFAULT_REGION == '' ]]
then
  echo "-d AWS_DEFAULT_REGION required"
  exit 1;
fi
if [[ $OWNER_NAME == '' ]]
then
  echo "-o OWNER_NAME required"
  exit 1;
fi
if [[ $AWS_REPLICATION_REGION == '' ]]
then
  echo "-r AWS_REPLICATION_REGION required"
  exit 1;
fi

# make sure we have aws cli
if ! [ -x "$(command -v aws)" ]; then
  echo 'error: aws-cli is not installed'
  exit 1
fi

# make sure we have jq
if ! [ -x "$(command -v jq)" ]; then
  echo 'error: jq is not installed'
  exit 1
fi

# Create destination resources first
echo "Creating destination resources for replication"
aws cloudformation create-stack \
  --region=$AWS_REPLICATION_REGION \
  --stack-name $CF_STACK_NAME \
  --template-body file://destination-region.yml \
  --parameters \
      ParameterKey=AccountName,ParameterValue=$ACCOUNT_NAME \
      ParameterKey=Owner,ParameterValue=$OWNER_NAME \
  --tags \
      Key=Application,Value=$APPLICATION \
      Key=Component,Value=$COMPONENT \
      Key=Environment,Value=$ACCOUNT_NAME \
      Key=Owner,Value=$OWNER_NAME \
  --output text

# Wait for destination template to be finished
while true
do
  CF_STATUS=$(aws cloudformation describe-stacks --region=$AWS_REPLICATION_REGION --stack-name $CF_STACK_NAME | jq -r .Stacks[0].StackStatus)

  echo "${CF_STACK_NAME} destination stack status: ${CF_STATUS}"

  if [[ $CF_FAILED_STATUSES =~ (^|[[:space:]])$CF_STATUS($|[[:space:]]) ]]
  then
    echo "${CF_STACK_NAME} failed"
    exit 1
  elif [[ $CF_SUCCESS_STATUSES =~ (^|[[:space:]])$CF_STATUS($|[[:space:]]) ]]
  then
    break
  fi

  sleep 10
done

echo "Destination resources are created"

# get the outputs from the relication template
echo "Creating source resources"
DESTINATION_CF_OUTPUTS=$( \
  aws cloudformation describe-stacks \
  --region=$AWS_REPLICATION_REGION \
  --stack-name $CF_STACK_NAME | \
  jq -r '.Stacks[0].Outputs' \
)

S3_REPLICATION_KMS_ARN=$(echo $DESTINATION_CF_OUTPUTS | jq -r '.[] | select(.OutputKey=="DefaultKmsKeyArn") | .OutputValue')
S3_REPLICATION_BUCKET_ARN=$(echo $DESTINATION_CF_OUTPUTS | jq -r '.[] | select(.OutputKey=="ReplicationBucketArn") | .OutputValue')

# Create source resources
aws cloudformation create-stack \
  --region=$AWS_DEFAULT_REGION \
  --stack-name $CF_STACK_NAME \
  --template-body file://source-region.yml \
  --parameters \
      ParameterKey=AccountName,ParameterValue=$ACCOUNT_NAME \
      ParameterKey=Owner,ParameterValue=$OWNER_NAME \
      ParameterKey=S3ReplicationKmsArn,ParameterValue=$S3_REPLICATION_KMS_ARN \
      ParameterKey=S3ReplicationBucketArn,ParameterValue=$S3_REPLICATION_BUCKET_ARN \
  --tags \
      Key=Application,Value=$APPLICATION \
      Key=Component,Value=$COMPONENT \
      Key=Environment,Value=$ACCOUNT_NAME \
      Key=Owner,Value=$OWNER_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --output text

# Wait for source template to be finished
while true
do
  CF_STATUS=$(aws cloudformation describe-stacks --region=$AWS_DEFAULT_REGION --stack-name $CF_STACK_NAME | jq -r .Stacks[0].StackStatus)

  echo "${CF_STACK_NAME} source stack status: ${CF_STATUS}"

  if [[ $CF_FAILED_STATUSES =~ (^|[[:space:]])$CF_STATUS($|[[:space:]]) ]]
  then
    echo "${CF_STACK_NAME} failed"
    exit 1;
  elif [[ $CF_SUCCESS_STATUSES =~ (^|[[:space:]])$CF_STATUS($|[[:space:]]) ]]
  then
    break
  fi

  sleep 10
done

SOURCE_CF_OUTPUTS=$( \
  aws cloudformation describe-stacks \
  --region=$AWS_DEFAULT_REGION \
  --stack-name $CF_STACK_NAME | \
  jq -r '.Stacks[0].Outputs' \
)

echo "Terraform S3 Bucket Arn: $(echo $SOURCE_CF_OUTPUTS | jq -r '.[] | select(.OutputKey=="TerraformBucketArn") | .OutputValue')"
echo "Terraform S3 Bucket Name: $(echo $SOURCE_CF_OUTPUTS | jq -r '.[] | select(.OutputKey=="TerraformBucketName") | .OutputValue')"
echo "Terraform DynamoDB Table Arn: $(echo $SOURCE_CF_OUTPUTS | jq -r '.[] | select(.OutputKey=="TerraformDynamoDbTableArn") | .OutputValue')"
echo "Terraform DynamoDB Table Name: $(echo $SOURCE_CF_OUTPUTS | jq -r '.[] | select(.OutputKey=="TerraformDynamoDbTableName") | .OutputValue')"
echo "Terraform KMS ARN: $(echo $SOURCE_CF_OUTPUTS | jq -r '.[] | select(.OutputKey=="TerraformKmsKeyArn") | .OutputValue')"

echo "Terraform backend complete"
