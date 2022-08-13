#!/bin/bash

if [ -z $TIDB_CLOUD_HOST ]; then
    TIDB_HOST=127.0.0.1
fi;

if [ -z $TIDB_CLOUD_USERNAME ]; then
    TIDB_USERNAME=root
fi;

export MYSQL_PS1="tidb> "

if [ -z $TIDB_CLOUD_PASSWORD ]; then
    mysql -h $TIDB_HOST -P 4000 -u $TIDB_USERNAME
else
    mysql -h $TIDB_CLOUD_HOST -P 4000 -u $TIDB_CLOUD_USERNAME -p$TIDB_CLOUD_PASSWORD
fi;

