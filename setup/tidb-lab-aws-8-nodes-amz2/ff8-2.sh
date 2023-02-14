#!/bin/bash

# Fast forward E8-1
./ff8-1.sh
source .bash_profile
source ./hosts-env.sh

# Fast forward E8-2
unzip -u stage/tidb-admin-dataset.zip -d stage/

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD2_PRIVATE_IP} unzip -u stage/tidb-admin-dataset.zip -d stage/

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD2_PRIVATE_IP} ./01-install-tiup.sh

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD2_PRIVATE_IP} ~/.tiup/bin/tiup install tidb-lightning

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
DROP DATABASE IF EXISTS my_db;
EOF

scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no lightning-p2.toml ${HOST_PD2_PRIVATE_IP}:~/lightning-p2.toml

nohup tiup tidb-lightning -config lightning-p1.toml > nohup.out & 
sleep 10
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD2_PRIVATE_IP} << 'EOF'
nohup ~/.tiup/bin/tiup tidb-lightning -config lightning-p2.toml > nohup.out &
EOF
sleep 10
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD2_PRIVATE_IP} cat nohup.out

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
SELECT COUNT(*) from my_db.my_table;
EOF
