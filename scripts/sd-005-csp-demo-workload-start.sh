#!/bin/bash

LB_DNS_NAME=`aws elbv2 describe-load-balancers --names demo-nlb --query "LoadBalancers[0].DNSName" --output text --region us-west-2`

./quick-demo-005-jdbc-endless-insert-dummy.sh ${LB_DNS_NAME}
