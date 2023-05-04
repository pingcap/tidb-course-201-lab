#!/bin/bash

LB_DNS_NAME=`aws elbv2 describe-load-balancers --names demo-nlb --query "LoadBalancers[0].DNSName" --output text --region us-west-2`

qdb(){
mysql -h ${LB_DNS_NAME} -P 4000 -uroot --connect-timeout 1 2>/dev/null << EOF
  SELECT COUNT(event) FROM test.dummy;
EOF
}

query(){
  echo;
  date;
  qdb
  sleep 2;
}

while true; do
  query;
done;
