#!/bin/bash

DC=`aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names TiKV \
  --query "AutoScalingGroups[0].DesiredCapacity" \
  --output text \
  --region us-west-2`

NEW_DC=$((${DC}+1))

aws autoscaling update-auto-scaling-group \
  --auto-scaling-group-name TiKV \
  --desired-capacity ${NEW_DC} \
  --min-size ${NEW_DC} \
  --region us-west-2 && echo TiKV server instances ${DC} to ${NEW_DC}
