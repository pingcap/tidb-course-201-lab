#!/bin/bash

source ../cloud-env.sh

LB_DNS_NAME=`aws elbv2 describe-load-balancers --names demo-nlb --query "LoadBalancers[0].DNSName" --output text --region ${REGION_CODE}`

mysql -h ${LB_DNS_NAME} -P 6000 -uroot << EOF
DROP TABLE IF EXISTS test.dummy; 
CREATE TABLE test.dummy (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(80), event JSON, tidb_instance VARCHAR(30));
EOF

./quick-demo-005-jdbc-endless-insert-dummy.sh ${LB_DNS_NAME}
