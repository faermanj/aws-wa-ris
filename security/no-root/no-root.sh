#!/usr/bin/env bash
STACK_ID="no-root"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TSTAMP="$(date -u +"%Y%m%dT%H%M%SZ")"

STACK_NAME="$STACK_ID-$TSTAMP"
TEMPLATE_FILE="$DIR/${STACK_ID}.yaml"
TEMPLATE_FILE_OUT="${TEMPLATE_FILE}.out"

aws cloudformation package \
    --template-file "$TEMPLATE_FILE" \
    --s3-bucket "$CODE_BUCKET" \
    --output-template-file "$TEMPLATE_FILE_OUT"


aws cloudformation deploy \
    --template-file "$TEMPLATE_FILE_OUT" \
    --stack-name "$STACK_NAME" \
    --capabilities CAPABILITY_IAM
