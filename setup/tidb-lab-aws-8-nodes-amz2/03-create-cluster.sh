#!/bin/bash

# Creating the TiDB cluster named tidb-test
~/.tiup/bin/tiup cluster deploy tidb-test 6.1.0 ./eight-nodes-hybrid.yaml --yes