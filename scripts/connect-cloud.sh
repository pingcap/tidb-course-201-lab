#!/bin/bash

export MYSQL_PS1="tidb-cloud> "

# Default `--ssl-ca` option is for macOS/Alpine. For other system, please modify the `--ssl-ca` option respectively.
# Debian/Unbuntu/Arch: --ssl-ca=/etc/ssl/certs/ca-certificates.crt
# CentOS/RedHat/Fedora: --ssl-ca=/etc/pki/tls/certs/ca-bundle.crt
# OpenSUSE: --ssl-ca=/etc/ssl/ca-bundle.pem

mysql --connect-timeout 15 --verbose \
  -u $TIDB_CLOUD_USERNAME \
  -h $TIDB_CLOUD_HOST \
  -P 4000 \
  --ssl-mode=VERIFY_IDENTITY \
  --ssl-ca=/etc/ssl/cert.pem \
  -p$TIDB_CLOUD_PASSWORD