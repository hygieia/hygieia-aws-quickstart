#!/usr/bin/env bash

script_dir="${0%/*}"
source $script_dir/config

# Remote commented & blank lines from deploy.properties
sed -i '' 's:^#.*$::g' deploy.properties
sed -i '' '/^[[:space:]]*$/d' deploy.properties

CMD=$(cat <<EOF
aws cloudformation package                     \
  --s3-bucket $S3_BUCKET                       \
  --region $AWS_REGION                         \
  --template-file $CFN_DIR/$DIRECTOR_TEMPLATE  \
  --output-template-file $PACKAGED_TEMPLATE
EOF
)

echo $CMD

eval $CMD
