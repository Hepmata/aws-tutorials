#!/bin/bash

role_arn="$1"
session="assume-role-script-$(date +%s)"

results=$(aws sts assume-role --role-arn "${role_arn}" --role-session-name "${session}")
echo "Copy and paste the following lines"
echo "export AWS_ACCESS_KEY_ID=\"$(echo "${results}" | jq -r .Credentials.AccessKeyId)\""
echo "export AWS_SECRET_ACCESS_KEY=\"$(echo "${results}" | jq -r .Credentials.SecretAccessKey)\""
echo "export AWS_SESSION_TOKEN=\"$(echo "${results}" | jq -r .Credentials.SessionToken)\""