#!/bin/bash

# FF E1
./ff1.sh
source .bash_profile
source ./hosts-env.sh

# FF E12-1
tiup install dm
tiup update --self && tiup update dm
