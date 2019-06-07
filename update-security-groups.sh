#!/bin/bash

# Updates the "MongoDBServerSecurityGroup" to give Hygieia ECS services access to MongoDB.

# Get the SG ID of the MongoDBServerSecurityGroup
MONGO_GROUP=$(aws ec2 describe-security-groups \
--filters Name=tag:aws:cloudformation:logical-id,Values=MongoDBServerSecurityGroup \
--query 'SecurityGroups[?GroupId].{GroupId: GroupId}' \
--output text)

# Get the SG ID of the Hygieia ECS Services
HYGIEIA_GROUP=$(aws ec2 describe-security-groups \
--filters Name=tag:aws:cloudformation:logical-id,Values=ContainerSG \
--query 'SecurityGroups[?GroupId].{GroupId: GroupId}' \
--output text)

# Add ingress rules to the MongoDBServerSecurityGroup
aws ec2 authorize-security-group-ingress \
--group-id $MONGO_GROUP \
--protocol tcp \
--port 28017 \
--source-group $HYGIEIA_GROUP

aws ec2 authorize-security-group-ingress \
--group-id $MONGO_GROUP \
--protocol tcp \
--port 27017-27030 \
--source-group $HYGIEIA_GROUP
