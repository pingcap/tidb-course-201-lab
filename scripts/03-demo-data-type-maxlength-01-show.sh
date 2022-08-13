#!/bin/bash

# ./03-demo-data-type-maxlength-01-show.sh

if [ -z $TIDB_CLOUD_HOST ]; then
  TIDB_HOST=127.0.0.1
else
  TIDB_HOST=$TIDB_CLOUD_HOST
fi;

if [ -z $TIDB_CLOUD_USERNAME ]; then
  TIDB_USERNAME=root
else
  TIDB_USERNAME=$TIDB_CLOUD_USERNAME
fi;

if [ -z $TIDB_CLOUD_PASSWORD ]; then
    TIDB_PASSWORD=""
else
    TIDB_PASSWORD=$TIDB_CLOUD_PASSWORD
fi;

export MYSQL_PS1="tidb> "

pip install -r ./misc/requirements-dt.txt
python demo-data-type-maxlength.py $*
