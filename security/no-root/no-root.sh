#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE=$(basename "${BASH_SOURCE[0]}")
STACK_NAME="${FILE%.*}"
TEMPLATE_FILE="$DIR/${STACK_NAME}.yaml"
TEMPLATE_FILE_OUT="${DIR}/target/${STACK_NAME}.yaml.out"
CODE_BUCKET=$(aws cloudformation describe-stack-resources \
  --stack-name "code-bucket" \
  --query "StackResources[?LogicalResourceId =='CodeBucket'].PhysicalResourceId" \
  --output text)

aws cloudformation package \
    --template-file "$TEMPLATE_FILE" \
    --s3-bucket "$CODE_BUCKET" \
    --output-template-file "$TEMPLATE_FILE_OUT"


aws cloudformation deploy \
    --template-file "$TEMPLATE_FILE_OUT" \
    --stack-name "$STACK_NAME" \
    --capabilities CAPABILITY_IAM
