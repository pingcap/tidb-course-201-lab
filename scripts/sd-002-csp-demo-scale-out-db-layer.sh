#!/bin/bash

DEMO_TG_ARN=`aws elbv2 describe-target-groups \
  --names demo-target-group \
  --query "TargetGroups[0].TargetGroupArn" \
  --output text \
  --region us-west-2`



aws elbv2 register-targets \
  --target-group-arn ${DEMO_TG_ARN} \
  --targets "Id=${HOST_DB1_PRIVATE_IP},Port=4000" "Id=${HOST_DB2_PRIVATE_IP},Port=4000" \
  --region us-west-2

echo TiDB instances registered to NLB target group ${DEMO_TG_ARN}

tiup cluster scale-out tidb-demo solution-scale-out-tikv.yaml --yes
