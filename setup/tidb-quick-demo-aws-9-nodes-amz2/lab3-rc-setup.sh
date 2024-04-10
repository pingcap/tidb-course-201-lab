#!/bin/bash

source ./hosts-env.sh

# For cluster
export MYSQL_PS1="tidb:db1> "
mysql -h ${HOST_DB1_PRIVATE_IP} -P 4000 -u root --verbose << 'EOFX'
ALTER USER userA RESOURCE GROUP default;
ALTER USER userB RESOURCE GROUP default;
DROP RESOURCE GROUP IF EXISTS rg1;
DROP RESOURCE GROUP IF EXISTS rg2;
CREATE RESOURCE GROUP rg1 RU_PER_SEC=500 PRIORITY=HIGH BURSTABLE;
CREATE RESOURCE GROUP rg2 RU_PER_SEC=500 PRIORITY=MEDIUM BURSTABLE;
ALTER USER userA RESOURCE GROUP rg1;
ALTER USER userB RESOURCE GROUP rg2;
SELECT * FROM information_schema.resource_groups;
SELECT Host,user, User_attributes FROM mysql.user WHERE user IN ('userA','userB');
EOFX
