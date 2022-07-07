#!/bin/bash

if [ -z $TIDB_HOST ]; then
    TIDB_HOST=127.0.0.1
fi;

if [ -z $TIDB_USERNAME ]; then
    TIDB_USERNAME=root
fi;

export MYSQL_PS1="tidb> "

if [ -z $TIDB_PASSWORD ]; then
    mysql -h $TIDB_HOST -P 4000 -u $TIDB_USERNAME --ssl-mode=REQUIRED
else
    mysql -h $TIDB_HOST -P 4000 -u $TIDB_USERNAME --ssl-mode=REQUIRED -p$TIDB_PASSWORD
fi;