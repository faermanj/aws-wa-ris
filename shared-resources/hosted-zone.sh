#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE=$(basename "${BASH_SOURCE[0]}")
STACK_NAME="${FILE%.*}"
TEMPLATE_FILE="$DIR/${STACK_NAME}.yaml"

DOMAIN_NAME="wa.julio.cloud"

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file "$TEMPLATE_FILE" \
  --parameter-overrides "DomainName=$DOMAIN_NAME"
