#!/usr/bin/env bash

script_dir="${0%/*}"
source $script_dir/config

CMD=$(cat <<EOF
aws cloudformation deploy                 \
  --s3-bucket $S3_BUCKET                  \
  --region $AWS_REGION                    \
  --template-file $PACKAGED_TEMPLATE      \
  --stack-name $STACK_NAME                \
  --capabilities $CAPABILITIES            \
  --parameter-overrides                   \
  $(cat $PROPERTIES_FILE)
EOF
)

echo $CMD

eval $CMD
