#!/bin/bash

TRAINER=${1}

python lib/03-terminate-instances-in-batch.py ${TRAINER}

echo "##########################"
echo "# Terminating all nodes. #"
echo "##########################"
