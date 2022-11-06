#!/bin/bash

# Run ./14-import-by-lightning-from-csv-parallel.sh

rm -rf ./misc/planets-csv-large-1
rm -rf ./misc/planets-csv-large-2

tiup dumpling --tables-list universe.planets --filetype csv --where "id < 327681" --output ./misc/planets-csv-large-1 &&\
tiup dumpling --tables-list universe.planets --filetype csv --where "id >= 327681" --output ./misc/planets-csv-large-2 &&\
echo ""
echo "PARALLEL IMPORTING universe.planets starts after 10 seconds."
echo ""
sleep 10

mysql -h 127.0.0.1 -P 4000 -u root < ./misc/drop-planets.sql && sleep 3

tiup tidb-lightning -config misc/lightning-universe-csv-parallel-1.toml &
sleep 1;
tiup tidb-lightning -config misc/lightning-universe-csv-parallel-2.toml
