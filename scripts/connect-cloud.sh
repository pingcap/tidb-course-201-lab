#!/bin/bash

export MYSQL_PS1="tidb-cloud> "

mysql -h $TIDB_CLOUD_HOST -P 4000 -u $TIDB_CLOUD_USERNAME -p$TIDB_CLOUD_PASSWORD

# For macOS. For other system, please modify `--ssl-ca` respectively.
mysql --connect-timeout 15 \
  -u $TIDB_CLOUD_USERNAME \
  -h $TIDB_CLOUD_HOST \
  -P 4000 \
  --ssl-mode=VERIFY_IDENTITY \
  --ssl-ca=/etc/ssl/cert.pem \
  -p$TIDB_CLOUD_PASSWORD