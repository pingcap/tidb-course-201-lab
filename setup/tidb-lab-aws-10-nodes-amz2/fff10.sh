#!/bin/bash

TRAINER_TAG=${1}
REGION_NAME=${2}

source .bash_profile
source ./hosts-env.sh
source ./cloud-env.sh

./fff8.sh

~/.tiup/bin/tiup install br:v6.5.1
unzip -u stage/tidb-admin-dataset.zip -d stage/

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_KV1_PRIVATE_IP} unzip -u stage/tidb-admin-dataset.zip -d stage/

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
DROP DATABASE IF EXISTS emp;
CREATE USER ltask@'%' IDENTIFIED BY 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO ltask@'%';
EOF

nohup ~/.tiup/bin/tiup tidb-lightning:v6.5.1 -config solution-lightning-init.toml > nohup.out &

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_KV1_PRIVATE_IP} mkdir /tmp/backup
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_KV2_PRIVATE_IP} mkdir /tmp/backup
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_KV3_PRIVATE_IP} mkdir /tmp/backup

~/.tiup/bin/tiup br:v6.5.1 backup full --pd "${HOST_PD1_PRIVATE_IP}:2379" --storage "local:///tmp/backup" --ratelimit 128 --log-file backupfull.log

ssh ${HOST_KV1_PRIVATE_IP} find /tmp/backup/

ls /tmp/backup/

~/.tiup/bin/tiup br:v6.5.1 backup db --db emp --pd "${HOST_PD1_PRIVATE_IP}:2379" --storage "s3://pe-class-${REGION_NAME}/${TRAINER_TAG}/user1/emp" --s3.region ${REGION_CODE} --send-credentials-to-tikv=false --ratelimit 128 --log-file backupdb.log