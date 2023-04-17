#!/bin/bash

q4000(){
mysql -h 127.0.0.1 -P 4000 -uroot 2>/dev/null << EOF
  SELECT name, COUNT(event) FROM test.dummy GROUP BY name ORDER BY name;
EOF
}

q4001(){
mysql -h 127.0.0.1 -P 4001 -uroot 2>/dev/null << EOF
  SELECT name, COUNT(event) FROM test.dummy GROUP BY name ORDER BY name;
EOF
}

query1(){
  echo;
  date;
  q4000 || q4001
  sleep 2;
}

query2(){
  echo;
  date;
  q4001 || q4000
  sleep 2;
}

while true; do
  query1;
  query2;
done;
