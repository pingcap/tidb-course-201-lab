#!/bin/bash

# Creating the TiDB cluster named tidb-test, version 6.1.1
~/.tiup/bin/tiup cluster deploy tidb-test 6.1.1 ./eight-nodes-hybrid.yaml --yes