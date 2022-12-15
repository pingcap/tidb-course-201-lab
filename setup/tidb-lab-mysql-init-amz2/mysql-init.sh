#!/bin/bash
wget -c http://dev.mysql.com/get/mysql-5.7.40-el7-x86_64.tar.gz
tar xvf mysql-5.7.40-el7-x86_64.tar.gz
sudo mv mysql-5.7.40-el7-x86_64 /usr/local/mysql
sudo groupadd mysql
sudo useradd -r -g mysql -s /bin/false mysql
sudo chown -R mysql.mysql /usr/local/mysql/
sudo mkdir -p /data/my3306
sudo chown -R mysql.mysql /data/my3306/
sudo mkdir -p /data/my3307
sudo chown -R mysql.mysql /data/my3307/