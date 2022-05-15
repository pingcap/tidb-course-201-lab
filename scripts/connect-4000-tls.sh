#!/bin/bash

export MYSQL_PS1="tidb> "
mysql -h 127.0.0.1 -P 4000 -u root --ssl-mode=REQUIRED