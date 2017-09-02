#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
STACK_ID="code-bucket"
TSTAMP="$(date -u +"%Y%m%dT%H%M%SZ")"
STACK_NAME="$STACK_ID-$TSTAMP"
TEMPLATE_FILE="$DIR/code-bucket.yaml"

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file "$TEMPLATE_FILE"

CODE_BUCKET=$(aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --query Stacks[0].Outputs[0].OutputValue \
  --output text)

echo "CODE_BUCKET=$CODE_BUCKET"
