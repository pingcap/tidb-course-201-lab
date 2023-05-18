#!/bin/bash

export MYSQL_PS1="tidb:4002> "

mysql -h 127.0.0.1 -P 4002 -u root --connect-timeout 1 --verbose