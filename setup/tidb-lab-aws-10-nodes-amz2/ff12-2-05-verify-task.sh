#!/bin/bash
REGION_NAME=${1}

# Fast forward E12-2-04
./ff12-2-04-start-task.sh ${REGION_NAME}
source .bash_profile
source ./hosts-env.sh

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
USE user_east;
SHOW TABLES;
SELECT * FROM information;
SELECT * FROM trace;
USE user_north;
SHOW TABLES;
SELECT * FROM information;
SELECT * FROM trace;
USE store;
SHOW TABLES;
SELECT * FROM store_bj;
SELECT * FROM store_tj;
SELECT * FROM store_suzhou;
SELECT * FROM store_sh;
USE salesdb;
SELECT * FROM sales;
EOF
