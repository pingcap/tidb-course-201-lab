#!/bin/bash

TRAINER=${1}

python lib/01-run-instances-in-batch.py ${TRAINER}

echo
echo "##################################################"
echo "# Waiting for 150 seconds for nodes starting up. #"
echo "##################################################"
echo

sleep 150;

python lib/02-assign-tags-in-batch.py ${TRAINER}

./check_nodes.sh
