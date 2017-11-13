#!/bin/sh

BUCKET_NAME="aws-wa-ris"
STACK_NAME="aws-wa-ris"

rm -rf ./target
rm -rf ./security/no-root/target/
mkdir -p ./target
mkdir -p ./security/no-root/target/

aws cloudformation package \
    --template-file ./security/no-root/no-root.yaml \
    --s3-bucket $BUCKET_NAME \
    --output-template-file ./security/no-root/target/no-root.out.yaml

aws cloudformation package \
    --template-file aws-wa-ris.yaml \
    --s3-bucket $BUCKET_NAME \
    --output-template-file ./target/aws-wa-ri.out.yaml

aws cloudformation deploy \
    --template-file ./target/aws-wa-ri.out.yaml \
    --stack-name $STACK_NAME \
    --capabilities CAPABILITY_IAM

