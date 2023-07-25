#!/bin/bash

# Fast forward E12-2-01
./ff12-2-01-mysql-setup.sh
source .bash_profile
source ./hosts-env.sh

mysql -h ${HOST_DB1_PRIVATE_IP} -P 4000 -uroot << 'EOF'
DROP USER IF EXISTS dm_user@'%';
CREATE USER dm_user@'%' identified by 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO dm_user@'%';
DROP DATABASE IF EXISTS user_north;
CREATE DATABASE user_north;
CREATE TABLE user_north.information(id INT PRIMARY KEY, info VARCHAR(64));
CREATE TABLE user_north.trace(id INT PRIMARY KEY, content VARCHAR(64));
DROP DATABASE IF EXISTS user_east;
CREATE DATABASE user_east;
CREATE TABLE user_east.information(id INT PRIMARY KEY, info VARCHAR(64));
CREATE TABLE user_east.trace(id INT PRIMARY KEY, content VARCHAR(64));
DROP DATABASE IF EXISTS store;
CREATE DATABASE store;
CREATE TABLE store.store_bj(id INT PRIMARY KEY, pname VARCHAR(64));
CREATE TABLE store.store_tj(id INT PRIMARY KEY, pname VARCHAR(64));
CREATE TABLE store.store_sh(id INT PRIMARY KEY, pname VARCHAR(64));
CREATE TABLE store.store_suzhou(id INT PRIMARY KEY, pname VARCHAR(64));
DROP DATABASE IF EXISTS salesdb;
CREATE DATABASE salesdb;
CREATE TABLE salesdb.sales(id INT PRIMARY KEY, pname varchar(20), cnt int);
DROP DATABASE IF EXISTS log;
CREATE DATABASE log;
CREATE TABLE log.messages(id INT PRIMARY KEY, msg VARCHAR(64));
EOF
