#!/bin/bash

# Fast forward E12-1
./ff12-1.sh
source .bash_profile
source ./hosts-env.sh

# Fast forward E12-2
sudo service mysqld start
./show-mysql-password.sh
mysql -h localhost -P 3306 -uroot -p << EOF
ALTER USER root@'localhost' identified by 'q1w2e3R4_';
EOF
