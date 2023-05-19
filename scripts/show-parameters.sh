#!/bin/bash

CLUSTER_NAME=${1}
SEARCH_PARAMETER=${2}

echo -e "\nSearching parameter or system variables contain \"${SEARCH_PARAMETER}\"\n"

TIDB_ID=`~/.tiup/bin/tiup cluster display ${CLUSTER_NAME}  2>/dev/null | egrep -i '^[0-9\.\:]{1,} {1,}tidb' | head -n 1 | awk -F" " '{print $1}'`

TIDB_ADDRESS=`echo ${TIDB_ID} | awk -F":" '{print $1}'`
TIDB_PORT=`echo ${TIDB_ID} | awk -F":" '{print $2}'`

echo -e "\n### Cluster Configurations:\n"
mysql -h ${TIDB_ADDRESS} -uroot -P${TIDB_PORT} << EOF
SHOW CONFIG WHERE name LIKE '%${SEARCH_PARAMETER}%';
EOF

echo -e "\n### System Variables:\n"
mysql -h ${TIDB_ADDRESS} -uroot -P${TIDB_PORT} << EOF
SHOW VARIABLES LIKE '%${SEARCH_PARAMETER}%';
EOF