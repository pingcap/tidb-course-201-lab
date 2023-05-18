#!/bin/bash

export MYSQL_PS1="tidb:4001> "

mysql -h 127.0.0.1 -P 4001 -u root --connect-timeout 1 --verbose