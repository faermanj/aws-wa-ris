#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE=$(basename "${BASH_SOURCE[0]}")
STACK_NAME="${FILE%.*}"
TEMPLATE_FILE="$DIR/${STACK_NAME}.yaml"
TEMPLATE_FILE_OUT="${DIR}/target/${STACK_NAME}.out.yaml"
CODE_BUCKET=$(aws cloudformation describe-stack-resources \
  --stack-name "code-bucket" \
  --query "StackResources[?LogicalResourceId =='CodeBucket'].PhysicalResourceId" \
  --output text)
ADMIN_PASSWORD="changemeplease"

rm -rf ./target
mkdir ./target

aws cloudformation package \
    --template-file "${DIR}/no-root/no-root.yaml" \
    --s3-bucket "$CODE_BUCKET" \
    --output-template-file "${DIR}/no-root/target/no-root.yaml"

aws cloudformation package \
    --template-file "$TEMPLATE_FILE" \
    --s3-bucket "$CODE_BUCKET" \
    --output-template-file "$TEMPLATE_FILE_OUT"

aws cloudformation create-stack \
    --template-body "file://$TEMPLATE_FILE_OUT" \
    --stack-name "$STACK_NAME" \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameters "ParameterKey=AdminPassword,ParameterValue=$ADMIN_PASSWORD"
