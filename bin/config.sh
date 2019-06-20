#!/usr/bin/env bash

# The S3 Bucket the packaged CloudFormation will be uploaded to
S3_BUCKET=hygieia-quickstart

# The AWS region Hygieia will be deployed to
AWS_REGION=us-east-1

# The CloudFormation Stack name associated with Hygieia
STACK_NAME=Hygieia-Quickstart


# You should not need to modify these
PROPERTIES_FILE=deploy.properties
CFN_DIR=cfn
CAPABILITIES=CAPABILITY_NAMED_IAM
PACKAGED_TEMPLATE=packaged.template
DIRECTOR_TEMPLATE=director.template
