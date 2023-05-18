#!/bin/bash

export MYSQL_PS1="tidb:4000> "

mysql -h 127.0.0.1 -P 4000 -u root --connect-timeout 1 --verbose
