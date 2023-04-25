#!/bin/bash

# Clean killed PD servers, should be only 1 PD server need to be cleaned as per the exercise workflow. However, this routine will clean all killed PD servers.
for PID in `~/.tiup/bin/tiup playground display 2>/dev/null | egrep -i '(killed|exit)' | grep -i pd | sort -g -r | awk -F" " '{print $1}'`; do
~/.tiup/bin/tiup playground scale-in --pid ${PID}
done;

sleep 3;

# Scale-out 1 PD server
~/.tiup/bin/tiup playground scale-out --pd 1

~/.tiup/bin/tiup playground display
