#!/bin/bash

# ./01-start-populate-planets.sh

mysql -h 127.0.0.1 -P 4000 -u root < universe.sql

pip install -r misc/requirements-dt.txt
python demo-endless-populate-planets.py