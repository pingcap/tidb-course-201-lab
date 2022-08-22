# Exercise 2: Prepared Statement

## Prerequisites
+ You had completed exercise [TiDB Architecture Basics Exercise 1b](https://eng.edu.pingcap.com/unit/view/id:2467)
+ Your TiDB service listens at port 4000.
+ The Java SDK environment is already configured on the operating system.
+ [git](https://git-scm.com/) is already installed on the operating system.

## Section 1: Preparation
1. Clone example scripts repository to the practice node (e.g: Your local macOS, Linux or Cloud VM provided by Amazon or GCP).
```
$ git clone https://github.com/pingcap/tidb-course-201-lab
```

2. Go to working directory: `tidb-course-201-lab/scripts`.
```
$ cd tidb-course-201-lab/scripts
```

3. If you have TiDB Cloud Developer Tier and you prefer to do the exercise on a Cloud node like Amazon EC2, please jump to *Section 5: Try it out on TiDB Cloud*.


## Section 2: Prepared Statement
1. Go through the sample code and note line `cachePrepStmts=true` in the method `main` -[DemoJdbcPreparedStatement.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcPreparedStatement.java)


2. Run demo script.
```
$ ./10-demo-jdbc-prepared-statement-01-show.sh
```

3. Run the other demo script. Note that the result is different from step 2.
```
$ ./10-demo-jdbc-prepared-statement-01-test.sh
```

4. Compare the different elapsed time between two runs. Try to find the reason for the different elapsed times in [DemoJdbcPreparedStatementTest.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcPreparedStatementTest.java). Try to fix it under your local `script` folder, so that following scripts can return the similar elapsed time.
	+ `./10-demo-jdbc-prepared-statement-01-show.sh` 
	+ `./10-demo-jdbc-prepared-statement-01-test.sh`	


## Section 3: Prepared statement with returning
1. Go through the sample code - [DemoJdbcPreparedStatementWithReturning.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcPreparedStatementWithReturning.java) 

2. Run demo script.
```
$ ./10-demo-jdbc-prepared-statement-returning-01-show.sh
```


## Section 4: Batch insert
1. Go through the sample code - [DemoJdbcBatchInsert.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcBatchInsert.java). Please note the `rewriteBatchedStatements=` in the code. If you set the value to false (which is the default setting), the statements will still be sent one by one during the actual network transfer.

2. Run demo script. 
```
$ ./10-demo-jdbc-batch-insert-01-show.sh local
```

3. Run the other demo script. Note that the result is different from step 2.
```
$ ./10-demo-jdbc-batch-insert-01-test.sh local
```

4. Try to fix the error in [DemoJdbcBatchInsertTest.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcBatchInsertTest.java) in your local `scripts` folder, so that following scripts can return the same result:
	+ `./10-demo-jdbc-batch-insert-01-show.sh` 
	+ `./10-demo-jdbc-batch-insert-01-test.sh`		

## Section 5: Try it out on TiDB Cloud
1. Until now, our exercises are targeting local TiDB Playground cluster. If you completed the [TiDB Architecture Basics Exercise 1a](https://eng.edu.pingcap.com/unit/view/id:2466), you can change the target database to TiDB Cloud Developer Tier. 
	+ Note: Each subsequent step requires you to do it on a practice node in the same Cloud Provider Region (e.g: Amazon EC2 instance) as your TiDB Cloud Developer Tier. Otherwise, the response latency may suffer. 

2. For executing prepared statement, locate JDBC URL "jdbc:mysql://localhost:4000/test", "root", "") in [DemoJdbcPreparedStatement.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcPreparedStatement.java) under the `scripts` folder on your practice node, change the `hostname`, `port`, `username` and `password` to corresponding values provided by your TiDB Cloud Developer Tier. And then, run the script.
```
$ ./10-demo-jdbc-prepared-statement-01-show.sh
```

3. For prepared statement returning, locate JDBC URL "jdbc:mysql://localhost:4000/test", "root", "") in [DemoJdbcPreparedStatementWithReturning.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcPreparedStatementWithReturning.java) under the `scripts` folder on your practice node, change the `hostname`, `port`, `username` and `password` to corresponding values provided by your TiDB Cloud Developer Tier. And then, run the script.
```
$ ./10-demo-jdbc-prepared-statement-returning-01-show.sh
```

4. Use parameter `cloud` to run the demo against TiDB Cloud. Before running the script, make sure the TiDB Cloud cluster has been started and then set environment variables for TiDB Cloud:
```
$ export TIDB_CLOUD_HOST=<hostname> 
$ export TIDB_CLOUD_USERNAME=<username> 
$ export TIDB_CLOUD_PASSWORD=<password> 
$ export TIDB_CLOUD_PORT=<port> 
```
And then, run the script.
```
$ ./10-demo-jdbc-batch-insert-01-show.sh cloud
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