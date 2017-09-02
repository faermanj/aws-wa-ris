#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
STACK_ID="coe-topic"
TSTAMP="$(date -u +"%Y%m%dT%H%M%SZ")"
STACK_NAME="$STACK_ID-$TSTAMP"
TEMPLATE_FILE="${DIR}/${STACK_ID}.yaml"

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file "$TEMPLATE_FILE"
