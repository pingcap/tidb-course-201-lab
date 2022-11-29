#!/bin/bash

# ./03-demo-data-type-maxlength-01-show.sh local|cloud [SQL_MODE]
# Example: ./03-demo-data-type-maxlength-01-show.sh local

export MYSQL_PS1="tidb> "
pip install -r ./misc/requirements-dt.txt

if [ $1 == "cloud" ]; then
  export TIDB_HOST=$TIDB_CLOUD_HOST
  export TIDB_USERNAME=$TIDB_CLOUD_USERNAME
  export TIDB_PASSWORD=$TIDB_CLOUD_PASSWORD
  export TIDB_PORT=$TIDB_CLOUD_PORT
  export MODE="cloud"
else
  export TIDB_HOST=127.0.0.1
  export TIDB_USERNAME=root
  export TIDB_PASSWORD=""
  export TIDB_PORT=4000
  export MODE="local"
fi;

python demo-data-type-maxlength.py $*
