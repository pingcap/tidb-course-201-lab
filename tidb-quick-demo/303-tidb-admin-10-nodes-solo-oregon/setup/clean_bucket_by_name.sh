#!/bin/bash

BUCKET_NAME=${1}
TRAINER_NAME=${2}

python lib/clean-bucket.py ${BUCKET_NAME} ${TRAINER_NAME}
