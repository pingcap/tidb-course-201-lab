# BP1: JDBC Batch Insert (Output)
+ Following output example is from TiUP playground
+ If the client and TiDB Cloud are not in the same region, the `elapsed time` gap between two executions will be quite large  
  + In case you cannot wait for the `rewriteBatchedStatements=false` run to complete, feel free to hit `ctrl-c`
```8
$ ./10-demo-jdbc-batch-insert-01-show.sh
TiDB Endpoint:127.0.0.1
TiDB Username:root
Connection established.
>>> Begin insert 10000 rows.
>>> End batch insert,~!@rewriteBatchedStatements=true,elapsed: 285 (ms)@!~.
Connection established.
>>> Begin insert 10000 rows.
>>> End batch insert,~!@rewriteBatchedStatements=false,elapsed: 11226 (ms)@!~.

/* Executing query: select count(*), max(name) from test.t1_batchtest; */
        Row#, count(*), max(name)
        1) 10000, 9999
Turn on autocommit.
Connection closed.
```