# Run the demo JDBC program and verify the result

1. Compile and run the Java class against the Playground TiDB cluster on local machine.
```bash
$ cd tidb-course-201-lab/
$ ./10-demo-jdbc-batch-insert-01-show.sh local

```

2. Check the output, compare the different elapsed time between two runs. You should see something similar to below. Verify that when JDBC parameter `rewriteBatchedStatements` is set to `true`, the performance is much better. 
```bash
$ ./10-demo-jdbc-batch-insert-01-show.sh local
TiDB endpoint: 127.0.0.1
TiDB username: root
Default TiDB server port: 4000
Connection established.
>>> Begin insert 10000 rows.
>>> End batch insert,rewriteBatchedStatements=true,elapsed: 527 (ms).
Connection established.
>>> Begin insert 10000 rows.
>>> End batch insert,rewriteBatchedStatements=false,elapsed: 9975 (ms).

/* Executing query: select count(*), max(name) from test.t1_batchtest; */
        Row#, count(*), max(name)
        1) 10000, 9999
Turn on autocommit.
Connection closed.
``` 

3. Compile and run the Java class against the TiDB Cloud. If the client and TiDB Cloud are not in the same region, the `elapsed time` gap between two executions will be quite large. In case you cannot wait for the `rewriteBatchedStatements=false` run to complete, feel free to hit `ctrl-c`
```bash
$ cd tidb-course-201-lab/
$ ./10-demo-jdbc-batch-insert-01-show.sh cloud

```