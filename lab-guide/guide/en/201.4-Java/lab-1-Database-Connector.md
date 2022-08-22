# Exercise 1: Database Connectors

## Prerequisites
+ You had completed exercise [TiDB Architecture Basics Exercise 1b](https://eng.edu.pingcap.com/unit/view/id:2467)
+ Your TiDB service listens at port 4000.
+ The Java SDK environment is already configured on the operating system.
+ [git](https://git-scm.com/) is already installed on the operating system.

## Prepare
1. Clone example scripts repository to the practice node (e.g: Your local macOS, Linux or Cloud VM provided by Amazon or GCP).
```
$ git clone https://github.com/pingcap/tidb-course-201-lab
```

2. Go to working directory: `tidb-course-201-lab/scripts`.
```
$ cd tidb-course-201-lab/scripts
```

3. If you have TiDB Cloud Developer Tier and you prefer to do the exercise on a Cloud node like Amazon EC2, please jump to section - [Try it out on TiDB Cloud](#try-it-out-on-tidb-cloud)

## Making connection to TiDB
1. Go through the sample code - [DemoJdbcConnection.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcConnection.java).

2. Run demo script, and note the output.
```
$ ./09-demo-jdbc-connection-01-show.sh
```

3. Run the other demo script, note the output error message. Compare the output with step 2.
```
$ ./09-demo-jdbc-connection-01-incorrect.sh 
```

4. Try to fix the error in [DemoJdbcConnectionIncorrect.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcConnectionIncorrect.java) in your local `scripts` folder, then run `./09-demo-jdbc-connection-01-incorrect.sh` again to verify that the result should be the same as the step 2. Tips: You can consult [DemoJdbcConnection.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcConnection.java) as a solution reference.

## Executing SQL update
1. Go through the sample code - [DemoJdbcExecuteUpdate.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteUpdate.java).

2. Run demo script.
```
$ ./09-demo-jdbc-execute-update-01-show.sh
```

## Executing SQL query
1. Go through the sample code and note line `ResultSet resultSet = statement.executeQuery(stmtText)` in the method `printResultSetStringString` - [DemoJdbcExecuteQuery.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteQuery.java).

2. Run demo script.
```
$ ./09-demo-jdbc-execute-query-01-show.sh
```

## Controlling transactions
1. Go through the sample code - [DemoJdbcExecuteUpdateTransactionControl.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteUpdateTransactionControl.java). Please note the `connection.setAutoCommit(false)` in the code, because of it the autocommit feature is disabled.

2. Run demo script.
```
$ ./09-demo-jdbc-execute-update-tx-01-show.sh
```

3. Run the other demo script and check the result. Note that the result is different from step 2.
```
$ ./09-demo-jdbc-execute-update-tx-01-incorrect.sh 
```

4. [DemoJdbcExecuteUpdateTransactionControlIncorrect.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteUpdateTransactionControlIncorrect.java) rolls back (`rollback()`) the transaction at certain point but it should be a `commit()`. Try to fix it under your local `script` folder, so that following scripts can return the same result:
	+ `./09-demo-jdbc-execute-update-tx-01-show.sh` 
	+ `./09-demo-jdbc-execute-update-tx-01-incorrect.sh`

## Null handling
1. Go through the sample code - [DemoJdbcNullHandling.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcNullHandling.java), and note that we use `resultSet.getInt(1)` and `resultSet.getString(2)` to show the values of the 1st and 2nd columns in the result set. And we use `resultSet.wasNull()` to test a certain column is null or not. 

2. Run demo script and check the result.
```
$ ./09-demo-jdbc-null-handling-01-show.sh
```

## Try it out on TiDB Cloud
1. Until now, our exercises are all targeting local TiDB Playground cluster. If you completed the [TiDB Architecture Basics Exercise 1a](https://eng.edu.pingcap.com/unit/view/id:2466), you can change the target database to TiDB Cloud Developer Tier. 
	+ Note: Each subsequent step requires you to do it on a practice node in the same Cloud Provider Region (e.g: Amazon EC2 instance) as your TiDB Cloud Developer Tier. Otherwise, the response latency may suffer. 

2. For making connection to TiDB, locate JDBC URL `"jdbc:mysql://localhost:4000/test", "root", "")` in [DemoJdbcConnection.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcConnection.java) under the `scripts` folder on your practice node, change the `hostname`, `port`, `username` and `password` to corresponding values provided by your TiDB Cloud Developer Tier. And then, run the connection test script.
```
$ ./09-demo-jdbc-connection-01-show.sh
```

3. For executing SQL update, locate JDBC URL `"jdbc:mysql://localhost:4000/test", "root", "")` in [DemoJdbcExecuteUpdate.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteUpdate.java) under the `scripts` folder on your practice node, change the `hostname`, `port`, `username` and `password` to corresponding values provided by your TiDB Cloud Developer Tier. And then, run the JDBC update script.
```
$ ./09-demo-jdbc-execute-update-01-show.sh
```

4. For executing SQL query, locate JDBC URL `"jdbc:mysql://localhost:4000/test", "root", "")` in [DemoJdbcExecuteQuery.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteQuery.java) under the `scripts` folder on your practice node, change the `hostname`, `port`, `username` and `password` to corresponding values provided by your TiDB Cloud Developer Tier. And then, run the JDBC query script.
```
$ ./09-demo-jdbc-execute-query-01-show.sh
```

5. For controlling transactions, locate JDBC URL `"jdbc:mysql://localhost:4000/test", "root", "")` in [DemoJdbcExecuteUpdateTransactionControl.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteUpdateTransactionControl.java) under the `scripts` folder on your practice node, change the `hostname`, `port`, `username` and `password` to corresponding values provided by your TiDB Cloud Developer Tier. And then, run the script.
```
$ ./09-demo-jdbc-execute-update-tx-01-show.sh
```

6. For null handling, locate JDBC URL `"jdbc:mysql://localhost:4000/test", "root", "")` in [DemoJdbcNullHandling.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcNullHandling.java) under the `scripts` folder on your practice node, change the `hostname`, `port`, `username` and `password` to corresponding values provided by your TiDB Cloud Developer Tier. And then, run the script.
```
$ ./09-demo-jdbc-null-handling-01-show.sh
```


## Making connection sample output 
```
$ ./09-demo-jdbc-connection-01-show.sh
Connection established.
Connection closed.
```

```
$ ./09-demo-jdbc-connection-01-incorrect.sh
Error: java.sql.SQLException: No suitable driver found for jdbc:mysq://localhost:40/test
Already disconnected.
```


## Executing SQL update sample output
```
$ ./09-demo-jdbc-execute-update-01-show.sh
Connection established.
Table test.t1 created.
1 row inserted into table test.t1
1 row inserted into table test.t1
2 row inserted into table test.t1
Connection closed.
```

## Executing SQL query sample output
```
$ ./09-demo-jdbc-execute-query-01-show.sh
Connection established.

/* Executing query: show variables like 'autocommit'; */
	Row#, Variable_name, Value
	1) autocommit, ON

/* Executing query: describe test.t1; */
	Row#, Field, Type
	1) id, int(11)
	2) name, char(4)

/* Executing query: explain select * from test.t1; */
	Row#, id, estRows
	1) TableReader_5, 10000.00
	2) └─TableFullScan_4, 10000.00

/* Executing query: select * from test.t1; */
	Row#, id, name

/* Executing query: insert into test.t1 values (100, 'WXYZ'); */
Error: java.sql.SQLException: Can not issue data manipulation statements with executeQuery().

/* Executing query: select * from test.t1; */
	Row#, id, name
Connection closed.
```

## Controlling transaction sample output
```
$ ./09-demo-jdbc-execute-update-tx-01-show.sh
Connection established.
Turn off autocommit.
Table test.t1 created.
1 row inserted into table test.t1 (commit).
1 row inserted into table test.t1 (commit).
1 row inserted into table test.t1 (commit).

/* Executing query: select count(*), max(id) from test.t1; */
	Row#, count(*), max(id)
	1) 4, 6629298651489370114
Turn on autocommit.
Connection closed.
```

```
$ ./09-demo-jdbc-execute-update-tx-01-incorrect.sh
Connection established.
Turn off autocommit.
Table test.t1 created.
1 row inserted into table test.t1 (commit).
1 row inserted into table test.t1 (commit).
1 row inserted into table test.t1 (commit).

/* Executing query: select count(*), max(id) from test.t1; */
	Row#, count(*), max(id)
	1) 2, 8935141660703064065
Turn on autocommit.
Connection closed.
```

## Null handling sample output
```
$ ./09-demo-jdbc-null-handling-01-show.sh
Connection established.
Turn off autocommit.
Table test.`t1` created.
1 row inserted into table test.`t1` (commit).

/* Executing query: select * from test.`t1`; */
	Row#, id, name
	1) '0': true, '': false
	2) '0': false, 'null': true
Turn on autocommit.
Connection closed.
```
