#!/bin/bash

# ./03-demo-data-type-maxlength-01-show.sh
pip uninstall mysql-connector -y
pip uninstall mysql-connector-python -y
pip install mysql-connector
pip install mysql-connector-python
python demo-data-type-maxlength.py