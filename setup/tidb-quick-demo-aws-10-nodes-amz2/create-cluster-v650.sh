#!/bin/bash

# Creating the TiDB cluster named tidb-demo, version 6.5.0
~/.tiup/bin/tiup cluster deploy tidb-demo 6.5.0 ./ten-nodes.yaml --yes