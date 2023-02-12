#!/bin/bash

# Fast forward E12-2-02
./ff12-2-02-tidb-setup.sh
source .bash_profile
source ./hosts-env.sh

X=`tiup dmctl --encrypt 'q1w2e3R4_'`

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

tiup dmctl --master-addr=${HOST_PD1_PRIVATE_IP}:8261 operate-source create mysql-source-conf1.yaml
tiup dmctl --master-addr=${HOST_PD1_PRIVATE_IP}:8261 operate-source create mysql-source-conf2.yaml

tiup dmctl --master-addr=${HOST_PD1_PRIVATE_IP}:8261 get-config source mysql-replica-01
tiup dmctl --master-addr=${HOST_PD1_PRIVATE_IP}:8261 get-config source mysql-replica-02

tiup dmctl --master-addr=${HOST_PD1_PRIVATE_IP}:8261 operate-source show
