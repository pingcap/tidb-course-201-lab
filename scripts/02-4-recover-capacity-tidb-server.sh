#!/bin/bash

# Clean killed TiDB servers, should be only 1 TiDB server need to be cleaned as per the exercise workflow. However, this routine will clean all killed TiDB servers.
for PID in `~/.tiup/bin/tiup playground display 2>/dev/null | egrep -i '(killed|exit)' | grep -i tidb | sort -g -r | awk -F" " '{print $1}'`; do
~/.tiup/bin/tiup playground scale-in --pid ${PID}
done;

sleep 3;

# Scale-out 1 TiDB server
~/.tiup/bin/tiup playground scale-out --db 1

~/.tiup/bin/tiup playground display
