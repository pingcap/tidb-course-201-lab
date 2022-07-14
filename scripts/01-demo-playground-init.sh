#!/bin/bash

./playground-clean-classroom.sh

tiup playground v6.1.0 --tag classroom --db 3 --pd 3 --kv 3 --tiflash 1
