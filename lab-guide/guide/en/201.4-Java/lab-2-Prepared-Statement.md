# Exercise 2: Prepared Statement

## Prerequisites
+ You had completed one of the following exercises:
  + [TiDB Architecture Basics Exercise 1a](https://eng.edu.pingcap.com/unit/view/id:2466)
  + [TiDB Architecture Basics Exercise 1b](https://eng.edu.pingcap.com/unit/view/id:2467)
+ The Java SDK environment is already configured on the operating system.
+ [git](https://git-scm.com/) is already installed on the operating system.


## Prepare
1. Clone example scripts repo to local.
```
$ git clone https://github.com/pingcap/tidb-course-201-lab
```

2. Go to working directory: `tidb-course-201-lab/scripts`.
```
$ cd tidb-course-201-lab/scripts
```


## Prepared Statement
1. Go through the sample code and note the line `30` -[DemoJdbcPreparedStatement.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcPreparedStatement.java)


2. Run demo script.
```
$ ./10-demo-jdbc-prepared-statement-01-show.sh
```

3. Run the other demo script and check the result. Note that the result is different from step 2.
```
$ ./10-demo-jdbc-prepared-statement-01-test.sh
```

4. Check the output, compare the different elapsed time between two runs. Try to find the reason for the different elapsed times in [DemoJdbcPreparedStatementTest.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcPreparedStatementTest.java).


## Prepared statement with returning
1. Go through the sample code and note the line `36` and line `48` - [DemoJdbcPreparedStatementWithReturning.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcPreparedStatementWithReturning.java)

2. Run demo script.
```
$ ./10-demo-jdbc-prepared-statement-returning-01-show.sh
```


## Batch insert
1. Go through the sample code and note the line `83`, `106`, `109` - [DemoJdbcBatchInsert.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcBatchInsert.java)

2. Run demo script. You can use parameter [cloud|local] to run the demo against TiDB Cloud or local Playground respectively. If you choose `cloud`, make sure the TiDB Cloud cluster has been started and then set environment variables for TiDB Cloud.
```
$ export TIDB_CLOUD_HOST=<hostname> 
$ export TIDB_CLOUD_USERNAME=<username> 
$ export TIDB_CLOUD_PASSWORD=<password> 
$ export TIDB_CLOUD_PORT=<port> 
```
```
$ ./10-demo-jdbc-batch-insert-01-show.sh cloud|local
```

3. Run the other demo script and check the result. Try to find the reason for the error in [DemoJdbcBatchInsertTest.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcBatchInsertTest.java).
```
$ ./10-demo-jdbc-batch-insert-01-test.sh cloud|local
```


## Prepared Statement sample output
```
$ ./10-demo-jdbc-prepared-statement-01-show.sh
Connection established.
>>> Reuse PS Begin repeating update.
>>> End repeating update, elapsed: 3832(ms).
>>> Non-Reuse PS Begin repeating update.
>>> End repeating update, elapsed: 4410(ms).

/* Executing query: select * from test.t1; */
	Row#, id, name
	1) 10, ABC
Turn on autocommit.
Connection closed.
```


```
$ ./10-demo-jdbc-prepared-statement-01-test.sh
Connection established.
>>> Reuse PS Begin repeating update.
>>> End repeating update, elapsed: 3892(ms).
>>> Non-Reuse PS Begin repeating update.
>>> End repeating update, elapsed: 6167(ms).

/* Executing query: select * from test.t1; */
	Row#, id, name
	1) 10, ABC
Turn on autocommit.
Connection closed.
```


## Batch insert sample output
```
$ ./10-demo-jdbc-batch-insert-01-show.sh local
TiDB endpoint: 127.0.0.1
TiDB username: root
Default TiDB server port: 4000
Connection established.
>>> Begin insert 10000 rows.
>>> End batch insert,rewriteBatchedStatements=true,elapsed: 161 (ms).
Connection established.
>>> Begin insert 10000 rows.
>>> End batch insert,rewriteBatchedStatements=false,elapsed: 4980 (ms).

/* Executing query: select count(*), max(name) from test.t1_batchtest; */
	Row#, count(*), max(name)
	1) 10000, 9999
Turn on autocommit.
Connection closed.
```

```
./10-demo-jdbc-batch-insert-01-test.sh local
TiDB endpoint: 127.0.0.1
TiDB username: root
Default TiDB server port: 4000
Connection established.
>>> Begin insert 10000 rows.
>>> End batch insert,rewriteBatchedStatements=true,elapsed: 3 (ms).
Connection established.
>>> Begin insert 10000 rows.
>>> End batch insert,rewriteBatchedStatements=false,elapsed: 4 (ms).

/* Executing query: select count(*), max(name) from test.t1_batchtest; */
	Row#, count(*), max(name)
	1) 0, null
Turn on autocommit.
Connection closed.
```