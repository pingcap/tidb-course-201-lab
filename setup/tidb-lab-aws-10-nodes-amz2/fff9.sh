#!/bin/bash

source .bash_profile
source ./hosts-env.sh

./fff8.sh

~/.tiup/bin/tiup install dumpling:v6.5.1
unzip -u stage/tidb-admin-dataset.zip -d stage/

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
DROP DATABASE IF EXISTS emp;
EOF

nohup ~/.tiup/bin/tiup tidb-lightning:v6.5.1 -config solution-lightning-sql.toml > nohup.out & 
sleep 10

~/.tiup/bin/tiup dumpling:v6.5.1 -uroot -P4000 -h ${HOST_DB1_PRIVATE_IP} --filetype sql -t 8 -o /tmp/dep -r 200000 -F 256MiB -T emp.dep

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD3_PRIVATE_IP} << 'EOFX'
echo "Operating on `hostname`"
unzip -u stage/tidb-admin-dataset.zip -d stage/
sudo service mysqld start
X=q1w2e3R4_
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << 'EOF'
DROP USER IF EXISTS exp@'%';
CREATE USER exp@'%' IDENTIFIED BY 'q1w2e3R4_';
GRANT ALL PRIVILEGES on *.* to exp@'%';
SOURCE ./stage/TiDB-Administration-exercise-data/exercise-09/emp-schema-create.sql
EOF
exit
EOFX

~/.tiup/bin/tiup dumpling:v6.5.1 -uexp -P 3306 -h ${HOST_PD3_PRIVATE_IP} -pq1w2e3R4_ --filetype sql -t 8 -o /tmp/empmysql -r 200000 -F 256MiB -B emp
