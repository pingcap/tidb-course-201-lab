#!/bin/bash

source ./hosts-env.sh
SEARCH_PARAMETER=${1}

echo -e "\n# Searching parameter or system variables contain \"${SEARCH_PARAMETER}\"\n"

TIDB_ADDRESS=${HOST_DB1_PRIVATE_IP}
TIDB_PORT=4000

echo -e "\n### Cluster Configurations:\n"
mysql -h ${TIDB_ADDRESS} -uroot -P${TIDB_PORT} << EOF
SHOW CONFIG WHERE name LIKE '%${SEARCH_PARAMETER}%';
EOF

echo -e "\n### System Variables:\n"
mysql -h ${TIDB_ADDRESS} -uroot -P${TIDB_PORT} << EOF
SHOW VARIABLES LIKE '%${SEARCH_PARAMETER}%';
EOF

echo