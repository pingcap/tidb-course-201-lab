#!/bin/bash

# Fast forward E8-1
./ff8-1.sh
source .bash_profile
source ./hosts-env.sh

# Fast forward E8-2
unzip -u stage/tidb-admin-dataset.zip -d stage/

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD1_PRIVATE_IP} unzip -u stage/tidb-admin-dataset.zip -d stage/

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD1_PRIVATE_IP} ./01-install-tiup.sh

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD1_PRIVATE_IP} ~/.tiup/bin/tiup install tidb-lightning:v6.5.1

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
DROP DATABASE IF EXISTS my_db;
EOF

rm -rf /tmp/tidb_lightning_checkpoint.pb

scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no solution-lightning-p2.toml ${HOST_PD1_PRIVATE_IP}:~/solution-lightning-p2.toml

nohup tiup tidb-lightning:v6.5.1 -config solution-lightning-p1.toml > nohup.out & 
sleep 10
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD1_PRIVATE_IP} << 'EOF'
~/.tiup/bin/tiup tidb-lightning:v6.5.1 -config solution-lightning-p2.toml
EOF

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD1_PRIVATE_IP} cat nohup.out

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
SELECT COUNT(*) from my_db.my_table;
EOF
