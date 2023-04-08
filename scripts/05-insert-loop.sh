#!/bin/bash

for i in {1..800};
  do
    mysql -h 127.0.0.1 -P 4000 -u root < ./misc/insert-into-auto-random.sql
  done;
