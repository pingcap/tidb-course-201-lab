#!/bin/bash

# Fast forward E12-2-03
./ff12-2-03-source-config.sh
source .bash_profile
source ./hosts-env.sh

cat << EOF > dm-task.yaml
name: "dm-task"
task-mode: all    # The task mode is set to full (only migrates full data). 
ignore-checking-items: ["auto_increment_id"] # Ignorable checking auto_increment_id.

target-database:  # set the host, port, user and password of the downstream database TiDB.
  host: "${HOST_DB1_PRIVATE_IP}"
  port: 4000
  user: "dm_user"
  password: "q1w2e3R4_"

mysql-instances:  # configure data sources that need to be migrated for the data migration task.
  - source-id: "mysql-replica-01"
    route-rules: ["instance-1-user-rule","sale-route-rule"]
    filter-rules: ["trace-filter-rule", "user-filter-rule" , "store-filter-rule"]
    block-allow-list: "log-ignored"
    mydumper-config-name: "global"
  - source-id: "mysql-replica-02"
    route-rules: ["instance-2-user-rule", "instance-2-store-rule","sale-route-rule"]
    filter-rules: ["trace-filter-rule", "user-filter-rule" , "store-filter-rule"]
    block-allow-list: "log-ignored"
    mydumper-config-name: "global"

routes:
# Rule 1: Migrate all tables in the user database in upstream MySQL instance with port 3306 to user_north database in the downstream TiDB instance. Migrate all tables in user database in upstream MySQL instance with port 3307 to user_east database in the downstream TiDB instance.
  instance-1-user-rule: # The first of the routing mapping rule.
    schema-pattern: "user"
    target-schema: "user_north"
  instance-2-user-rule:
    schema-pattern: "user"
    target-schema: "user_east"
  
# Rule 2: Migrate all tables in store database in upstream MySQL instance to store database in the downstream TiDB instance, except the table store.store_sz in upstream MySQL instances with port 3307 to the table store.store_suzhou in the downstream TiDB instance.
  instance-2-store-rule:
    schema-pattern: "store"
    table-pattern: "store_sz"
    target-schema: "store"
    target-table: "store_suzhou"
  
# Rule 3: Migrate the table salesdb.sales which is sharded schemas in upstream MySQL instances with port 3306 and 3307 in the two upstream MySQL instances to the salesdb.sales tables in the downstream TiDB instance.
  sale-route-rule:
    schema-pattern: "salesdb"
    target-schema: "salesdb"

# Rule 4: Any delete DML event on user.*, any drop table, truncate table DDL event on table user.trace and any delete, truncate table, drop table DDL event on store database in any upstream MySQL instance will not be replicated to the downstream TiDB instance.
filters:
  trace-filter-rule:
    schema-pattern: "user"
    table-pattern: "trace"
    events: ["truncate table", "DROP TABLE", "delete"]
    action: Ignore
  user-filter-rule:
    schema-pattern: "user"
    events: ["drop database"]
    action: Ignore
  store-filter-rule:
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
