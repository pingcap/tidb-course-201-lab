#!/bin/bash
REGION_NAME=${1}

source .bash_profile
source ./hosts-env.sh

./fff7.sh ${REGION_NAME}

wget https://download.pingcap.org/tidb-community-toolkit-v6.5.1-linux-amd64.tar.gz
tar xvf tidb-community-toolkit-v6.5.1-linux-amd64.tar.gz

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD3_PRIVATE_IP} << 'EOFX'
echo "Operating on `hostname`"
sudo service mysqld start
X=q1w2e3R4_
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << 'EOF'
DROP USER IF EXISTS ins@'%';
CREATE USER ins@'%' IDENTIFIED BY 'q1w2e3R4_';
GRANT ALL PRIVILEGES on *.* to ins@'%';
CREATE DATABASE test1;
USE test1;
CREATE TABLE T1(id INT(11) NOT NULL PRIMARY KEY, name VARCHAR(32));
CREATE TABLE T2(id INT(11), name VARCHAR(32));
CREATE TABLE T3(id INT(11) NOT NULL PRIMARY KEY, name VARCHAR(32));
CREATE TABLE T4(id INT(11), name VARCHAR(32));
INSERT INTO T1 VALUES (1,'Tom'), (2,'Jack'), (3,'Frank'), (4,'Tony');
INSERT INTO T2 VALUES (1,'Tom'), (2,'Jack'), (3,'Frank'), (4,'Tony');
INSERT INTO T3 VALUES (1,'Tom'), (2,'Jack'), (3,'Frank'), (4,'Tony');
INSERT INTO T4 VALUES (1,'Tom'), (2,'Jack'), (3,'Frank'), (4,'Tony');
EOF
exit
EOFX

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
DROP DATABASE IF EXISTS ins;
CREATE USER ins@'%' IDENTIFIED BY 'q1w2e3R4_';
GRANT ALL PRIVILEGES on *.* to ins@'%';
CREATE DATABASE test1;
USE test1;
CREATE TABLE T1(id INT(11) NOT NULL PRIMARY KEY, name VARCHAR(32));
CREATE TABLE T2(id INT(11), name VARCHAR(32));
CREATE TABLE T3(id INT(11) NOT NULL PRIMARY KEY, name VARCHAR(32));
CREATE TABLE T4(id INT(11), name VARCHAR(32));
INSERT INTO T1 VALUES (1,'Tom'), (2,'Jack'), (3,'Frank'), (4,'Tony');
INSERT INTO T2 VALUES (1,'Tom'), (2,'Jack'), (3,'Frank'), (4,'Tony');
INSERT INTO T3 VALUES (1,'Tom'), (2,'Jack'), (3,'Frank'), (4,'Tony');
INSERT INTO T4 VALUES (1,'Tom'), (2,'Jack'), (3,'Frank'), (4,'Tony');
EOF

./tidb-community-toolkit-v6.5.1-linux-amd64/sync_diff_inspector --config=./solution-sync-diff-config.toml

cat ./output/summary.txt

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD3_PRIVATE_IP} << 'EOFX'
echo "Operating on `hostname`"
sudo service mysqld start
X=q1w2e3R4_
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << 'EOF'
USE test1;
INSERT INTO T1 SELECT 5, 'Candy';
INSERT INTO T2 SELECT 5, 'Candy';
INSERT INTO T3 SELECT 5, 'Candy';
INSERT INTO T4 SELECT 5, 'Candy';
DELETE FROM T1 WHERE id=4;
DELETE FROM T2 WHERE id=4;
DELETE FROM T3 WHERE id=4;
DELETE FROM T4 WHERE id=4;
UPDATE T1 SET NAME='Andy' WHERE id=1;
UPDATE T2 SET NAME='Andy' WHERE id=1;
UPDATE T3 SET NAME='Andy' WHERE id=1;
UPDATE T4 SET NAME='Andy' WHERE id=1;
EOF
exit
EOFX

./tidb-community-toolkit-v6.5.1-linux-amd64/sync_diff_inspector --config=./solution-sync-diff-config.toml

cat ./output/summary.txt   