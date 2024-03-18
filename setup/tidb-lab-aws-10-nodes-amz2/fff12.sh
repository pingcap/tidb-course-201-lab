#!/bin/bash

source .bash_profile
source ./hosts-env.sh

./fff8.sh

# Fast forward E12-1
~/.tiup/bin/tiup install dm dmctl:v6.5.1
# tiup update --self && tiup update dm && tiup update dm
~/.tiup/bin/tiup dm deploy dm-test v6.5.1 ./solution-dm-topology-six-nodes.yaml --yes
~/.tiup/bin/tiup dm start dm-test

# Fast forward E12-2-mysql-setup
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD1_PRIVATE_IP} << 'EOFX'
echo "Operating on `hostname`"
sudo service mysqld start
X=q1w2e3R4_
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << 'EOF'
DROP USER IF EXISTS dm_user@'%';
CREATE USER dm_user@'%' identified by 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO dm_user@'%';
SET @@global.show_compatibility_56=ON;
EOF
exit
EOFX

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD2_PRIVATE_IP} << 'EOFX'
echo "Operating on `hostname`"
sudo service mysqld start
X=q1w2e3R4_
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << 'EOF'
DROP USER IF EXISTS dm_user@'%';
CREATE USER dm_user@'%' identified by 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO dm_user@'%';
SET @@global.show_compatibility_56=ON;
EOF
exit
EOFX

cd ./stage/
unzip tidb-admin-dataset.zip 1>/dev/null 2>&1
cd -
mysql -udm_user -pq1w2e3R4_ -h ${HOST_PD1_PRIVATE_IP} -P3306 < stage/TiDB-Administration-exercise-data/exercise-12/3306db.sql
mysql -udm_user -pq1w2e3R4_ -h ${HOST_PD2_PRIVATE_IP} -P3306 < stage/TiDB-Administration-exercise-data/exercise-12/3307db.sql 

mysql -h ${HOST_DB1_PRIVATE_IP} -P 4000 -uroot << 'EOF'
DROP USER IF EXISTS dm_user@'%';
CREATE USER dm_user@'%' identified by 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO dm_user@'%';
DROP DATABASE IF EXISTS user_north;
CREATE DATABASE user_north;
CREATE TABLE user_north.information(id INT PRIMARY KEY, info VARCHAR(64));
CREATE TABLE user_north.trace(id INT PRIMARY KEY, content VARCHAR(64));
DROP DATABASE IF EXISTS user_east;
CREATE DATABASE user_east;
CREATE TABLE user_east.information(id INT PRIMARY KEY, info VARCHAR(64));
CREATE TABLE user_east.trace(id INT PRIMARY KEY, content VARCHAR(64));
DROP DATABASE IF EXISTS store;
CREATE DATABASE store;
CREATE TABLE store.store_bj(id INT PRIMARY KEY, pname VARCHAR(64));
CREATE TABLE store.store_tj(id INT PRIMARY KEY, pname VARCHAR(64));
CREATE TABLE store.store_sh(id INT PRIMARY KEY, pname VARCHAR(64));
CREATE TABLE store.store_suzhou(id INT PRIMARY KEY, pname VARCHAR(64));
DROP DATABASE IF EXISTS salesdb;
CREATE DATABASE salesdb;
CREATE TABLE salesdb.sales(id INT PRIMARY KEY, pname varchar(20), cnt int);
DROP DATABASE IF EXISTS log;
CREATE DATABASE log;
CREATE TABLE log.messages(id INT PRIMARY KEY, msg VARCHAR(64));
EOF

X=`~/.tiup/bin/tiup dmctl:v6.5.1 --encrypt 'q1w2e3R4_'`

cat << EOF > mysql-source-conf1.yaml
source-id: "mysql-replica-01"
from:
  host: "${HOST_PD1_PRIVATE_IP}"
  port: 3306
  user: "dm_user"
  password: "${X}"
EOF

cat << EOF > mysql-source-conf2.yaml
source-id: "mysql-replica-02"
from:
  host: "${HOST_PD2_PRIVATE_IP}"
  port: 3306
  user: "dm_user"
  password: "${X}"
EOF

~/.tiup/bin/tiup dmctl:v6.5.1 --master-addr=${HOST_PD1_PRIVATE_IP}:8261 operate-source create mysql-source-conf1.yaml
~/.tiup/bin/tiup dmctl:v6.5.1 --master-addr=${HOST_PD1_PRIVATE_IP}:8261 operate-source create mysql-source-conf2.yaml

~/.tiup/bin/tiup dmctl:v6.5.1 --master-addr=${HOST_PD1_PRIVATE_IP}:8261 get-config source mysql-replica-01
~/.tiup/bin/tiup dmctl:v6.5.1 --master-addr=${HOST_PD1_PRIVATE_IP}:8261 get-config source mysql-replica-02

~/.tiup/bin/tiup dmctl:v6.5.1 --master-addr=${HOST_PD1_PRIVATE_IP}:8261 operate-source show

cat << EOF > dm-task.yaml
name: "dm-task"
task-mode: all    # The task mode is set to full (only migrates full data). 
ignore-checking-items: ["auto_increment_ID"] # Ignorable checking auto_increment_ID.

target-database:  # set the host, port, user and password of the downstream database TiDB.
  host: "${HOST_DB1_PRIVATE_IP}"
  port: 4000
  user: "dm_user"
  password: "${X}"

mysql-instances:  # configure data sources that need to be migrated for the data migration task.
  - source-id: "mysql-replica-01"
    route-rules: ["instance-1-user-schema-rule","salesdb-schema-route-rule"]
    filter-rules: ["trace-table-filter-rule", "user-table-filter-rule" , "store-table-filter-rule"]
    block-allow-list: "log-ignored"
    mydumper-config-name: "global"
  - source-id: "mysql-replica-02"
    route-rules: ["instance-2-user-schema-rule", "instance-2-store-schema-rule","salesdb-schema-route-rule"]
    filter-rules: ["trace-table-filter-rule", "user-table-filter-rule" , "store-table-filter-rule"]
    block-allow-list: "log-ignored"
    mydumper-config-name: "global"

routes:
# Rule 1: Migrate all tables in the user database in upstream MySQL instance with port 3306 to user_north database in the downstream TiDB instance. Migrate all tables in user database in upstream MySQL instance with port 3307 to user_east database in the downstream TiDB instance.
  instance-1-user-schema-rule: # The first of the routing mapping rule.
    schema-pattern: "user"
    target-schema: "user_north"
  instance-2-user-schema-rule:
    schema-pattern: "user"
    target-schema: "user_east"
  
# Rule 2: Migrate all tables in store database in upstream MySQL instance to store database in the downstream TiDB instance, except the table store.store_sz in upstream MySQL instances with port 3307 to the table store.store_suzhou in the downstream TiDB instance.
  instance-2-store-schema-rule:
    schema-pattern: "store"
    table-pattern: "store_sz"
    target-schema: "store"
    target-table: "store_suzhou"
  
# Rule 3: Migrate the table salesdb.sales which is sharded schemas in upstream MySQL instances with port 3306 and 3307 in the two upstream MySQL instances to the salesdb.sales tables in the downstream TiDB instance.
  salesdb-schema-route-rule:
    schema-pattern: "salesdb"
    target-schema: "salesdb"

# Rule 4: Any delete DML event on user.*, any drop table, truncate table DDL event on table user.trace and any delete, truncate table, drop table DDL event on store database in any upstream MySQL instance will not be replicated to the downstream TiDB instance.
filters:
  trace-table-filter-rule:
    schema-pattern: "user"
    table-pattern: "trace"
    events: ["truncate table", "DROP TABLE", "delete"]
    action: Ignore
  user-table-filter-rule:
    schema-pattern: "user"
    events: ["drop database"]
    action: Ignore
  store-table-filter-rule:
    schema-pattern: "store"
    events: ["drop database", "truncate table", "DROP TABLE", "delete"]
    action: Ignore

# Rule 5: The log databases in any upstream MySQL instance will not be replicated to the downstream TiDB instance.
block-allow-list:
  log-ignored:
    ignore-dbs: ["log"]
mydumpers:
  global:
    threads: 4
    chunk-filesize: 64
EOF

~/.tiup/bin/tiup dmctl:v6.5.1 --master-addr=${HOST_PD1_PRIVATE_IP}:8261 check-task ./dm-task.yaml
~/.tiup/bin/tiup dmctl:v6.5.1 --master-addr=${HOST_PD1_PRIVATE_IP}:8261 start-task dm-task.yaml
~/.tiup/bin/tiup dmctl:v6.5.1 --master-addr=${HOST_PD1_PRIVATE_IP}:8261 query-status dm-task.yaml
