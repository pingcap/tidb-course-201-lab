#!/bin/bash

LB_DNS_NAME=`aws elbv2 describe-load-balancers --names demo-nlb --query "LoadBalancers[0].DNSName" --output text --region us-west-2`

mysql -h ${LB_DNS_NAME} -P 4000 -uroot << EOF
SELECT BENCHMARK(800000000,AES_ENCRYPT('hello','goodbye'));
EOF
