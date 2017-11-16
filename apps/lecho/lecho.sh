#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE=$(basename "${BASH_SOURCE[0]}")
STACK_NAME="${FILE%.*}"
ZIP="${DIR}/target/${STACK_NAME}.zip"
TEMPLATE_FILE="$DIR/${STACK_NAME}.yaml"
TEMPLATE_FILE_OUT="${DIR}/target/${STACK_NAME}.out.yaml"
CODE_BUCKET=$(aws cloudformation describe-stack-resources \
  --stack-name "code-bucket" \
  --query "StackResources[?LogicalResourceId =='CodeBucket'].PhysicalResourceId" \
  --output text)

rm -rf ./target
mkdir ./target

cd ${DIR}/src
zip -r $ZIP ./*
cd ${DIR}
zip -ur $ZIP node_modules
unzip -vl $ZIP

aws cloudformation package \
    --template-file "$TEMPLATE_FILE" \
    --s3-bucket "$CODE_BUCKET" \
    --output-template-file "$TEMPLATE_FILE_OUT"

aws cloudformation delete-stack \
    --stack-name "$STACK_NAME"

aws cloudformation wait stack-delete-complete \
    --stack-name "$STACK_NAME"

aws cloudformation create-stack \
    --template-body "file://$TEMPLATE_FILE_OUT" \
    --stack-name "$STACK_NAME" \
    --capabilities CAPABILITY_IAM
