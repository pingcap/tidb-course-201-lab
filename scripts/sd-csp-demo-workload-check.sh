#!/bin/bash

qdb1(){
mysql -h ${HOST_DB1_PRIVATE_IP} -P 4000 -uroot --connect-timeout 1 2>/dev/null << EOF
  SELECT name, COUNT(event) FROM test.dummy GROUP BY name ORDER BY name;
EOF
}

qdb2(){
mysql -h ${HOST_DB2_PRIVATE_IP} -P 4000 -uroot --connect-timeout 1 2>/dev/null << EOF
  SELECT name, COUNT(event) FROM test.dummy GROUP BY name ORDER BY name;
EOF
}

query1(){
  echo;
  date;
  qdb1 || qdb2
  sleep 2;
}

query2(){
  echo;
  date;
  qdb2 || qdb1
  sleep 2;
}

while true; do
  query1;
  query2;
done;
