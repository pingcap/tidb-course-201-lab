#!/bin/bash

# Run ./21-demo-jdbc-mydb-emp-universe-dummy-workload.sh


./21-demo-jdbc-mydb-dummy-workload.sh &
./21-demo-jdbc-emp-dummy-workload.sh &
./21-demo-jdbc-universe-dummy-workload.sh &
