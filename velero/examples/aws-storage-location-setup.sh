#!/bin/bash

REGION=us-east-1
aws s3api create-bucket --bucket velero-backu --region $REGION --create-bucket-configuration LocationConstraint=$REGION

aws iam create-user --user-name velero

aws iam put-user-policy --user-name velero --policy-name velero --policy-document ./velero-policy.json

aws iam create-access-key --user-name velero