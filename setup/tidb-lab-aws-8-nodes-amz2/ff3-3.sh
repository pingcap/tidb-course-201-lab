#!/bin/bash

# Fast forward E3-2
./ff3-2.sh
source .bash_profile
source ./hosts-env.sh

cp .tiup/storage/cluster/clusters/tidb-test/meta.yaml .tiup/storage/cluster/clusters/tidb-test/meta.yaml.bak
cp ./solution-tiup-meta.yaml .tiup/storage/cluster/clusters/tidb-test/meta.yaml

tiup cluster reload tidb-test --yes

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
SHOW CONFIG WHERE type='tikv' and name='log.level';
EOF

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_KV1_PRIVATE_IP} cat /tidb-deploy/tikv-20160/conf/tikv.toml
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_KV2_PRIVATE_IP} cat /tidb-deploy/tikv-20160/conf/tikv.toml
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_KV3_PRIVATE_IP} cat /tidb-deploy/tikv-20160/conf/tikv.toml
