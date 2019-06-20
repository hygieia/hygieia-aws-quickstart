#!/usr/bin/env bash

script_dir="${0%/*}"
source $script_dir/config

CMD=$(cat <<EOF
aws cloudformation delete-stack --stack-name $STACK_NAME --region $AWS_REGION
EOF
)

echo $CMD

eval $CMD
