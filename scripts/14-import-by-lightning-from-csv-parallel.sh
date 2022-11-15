#!/bin/bash

# Run ./14-import-by-lightning-from-csv-parallel.sh

# Clean up Dumpling destinations.
rm -rf ./misc/planets-csv-large-1
rm -rf ./misc/planets-csv-large-2

# Clean up operation log.
> ../stage/tidb-lightning-universe.log

# Dump universe.planets table into 2 folders.
tiup dumpling --tables-list universe.planets --filetype csv --where "id < 327681" --output ./misc/planets-csv-large-1 &&\
tiup dumpling --tables-list universe.planets --filetype csv --where "id >= 327681" --output ./misc/planets-csv-large-2 &&\
echo ""
echo "PARALLEL IMPORTING universe.planets begins after 10 seconds."
echo ""
sleep 10

# Remove universe.planets table.
mysql -h 127.0.0.1 -P 4000 -u root < ./misc/drop-planets.sql && sleep 3

# Parallel importing back universe.planets table - degree of parallelism = 2
echo ""
echo "Lightning Instance 1"
echo ""
tiup tidb-lightning -config misc/lightning-universe-csv-parallel-1.toml &
sleep 1;
echo ""
echo "Lightning Instance 2"
echo ""
tiup tidb-lightning -config misc/lightning-universe-csv-parallel-2.toml
