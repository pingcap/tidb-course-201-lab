#!/bin/bash

source ../cloud-env.sh

LB_DNS_NAME=`aws elbv2 describe-load-balancers --names demo-nlb --query "LoadBalancers[0].DNSName" --output text --region ${REGION_CODE}`

source ../hosts-env.sh

qdb(){
mysql -h ${LB_DNS_NAME} -P 6000 -uroot --connect-timeout 1 2>/dev/null << EOF
  SELECT tidb_instance, COUNT(event) FROM test.dummy GROUP BY tidb_instance ORDER BY tidb_instance;
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
