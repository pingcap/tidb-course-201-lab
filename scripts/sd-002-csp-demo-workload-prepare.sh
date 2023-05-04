#!/bin/bash

LB_DNS_NAME=`aws elbv2 describe-load-balancers --names demo-nlb --query "LoadBalancers[0].DNSName" --output text --region us-west-2`

mysql -h ${LB_DNS_NAME} -P 4000 -uroot << EOF
SET CONFIG PD replication.max-replicas=3;
DROP TABLE IF EXISTS test.dummy; 
CREATE TABLE test.dummy (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(80), event JSON);
EOF
