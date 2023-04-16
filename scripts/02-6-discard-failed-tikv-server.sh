#!/bin/bash

# Clean killed TiKV servers, should be only 1 TiKV server need to be cleaned as per the exercise workflow. However, this routine will clean all killed TiKV servers.
for PID in `~/.tiup/bin/tiup playground display 2>/dev/null | egrep -i '(killed|exit)' | grep -i tikv | sort -g -r | awk -F" " '{print $1}'`; do
~/.tiup/bin/tiup playground scale-in --pid ${PID}
done;