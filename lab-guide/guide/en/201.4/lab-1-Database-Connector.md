# Exercise 1: Database Connectors

## Prerequisites
+ You had completed one of the following execercies:
  + [TiDB Architecture Basics Exercise 1a](https://eng.edu.pingcap.com/unit/view/id:2466)
  + [TiDB Architecture Basics Exercise 1b](https://eng.edu.pingcap.com/unit/view/id:2467)
+ The Java SDK environment is already configured on the operating system.
+ [git](https://git-scm.com/) is already installed on the operating system.

## Prepare
1. Clone example scripts repository to local.
```
$ git clone https://github.com/pingcap/tidb-course-201-lab
```

2. Go to working directory: `tidb-course-201-lab/scripts`.
```
$ cd tidb-course-201-lab/scripts
```

## Make connection
1. Go through the sample code - [DemoJdbcConnection.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcConnection.java)

2. Run demo script.
```
$ ./09-demo-jdbc-connection-01-show.sh
```

3. Run the other demo script，find output error message.
```
$ ./09-demo-jdbc-connection-01-incorrect.sh 
```

4. Check the output, compare the difference between two runs. Do your best to fix the error in [DemoJdbcConnectionIncorrect.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcConnectionIncorrect.java), then run `./09-demo-jdbc-connection-01-incorrect.sh` again to verify the result.

## Execute SQL update 
1. Go through the sample code - [DemoJdbcExecuteUpdate.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteUpdate.java)

2. Run demo script.
```
$ ./09-demo-jdbc-execute-update-01-show.sh
```

## Execute query
1. Go through the sample code and note line `14` and line `45` - [DemoJdbcExecuteQuery.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteQuery.java)

2. Run demo script.
```
$ ./09-demo-jdbc-execute-query-01-show.sh
```

## Transaction control
1. Go through the sample code - [DemoJdbcExecuteUpdateTransactionControl.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteUpdateTransactionControl.java)

2. Run demo script.
```
$ ./09-demo-jdbc-execute-update-tx-01-show.sh
```

3. Run the other demo script and check the result. Note that the result is different from step 2.
```
$ ./09-demo-jdbc-execute-update-tx-01-incorrect.sh 
```

4. Do your best to modify [DemoJdbcExecuteUpdateTransactionControlIncorrect.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteUpdateTransactionControlIncorrect.java), so that `./09-demo-jdbc-execute-update-tx-01-incorrect.sh` and `./09-demo-jdbc-execute-update-tx-01-show.sh` can return the same the result.


## Null handling
1. Go through the sample code and note the line `18`, `19`, `43`, `47`, `48` - [DemoJdbcNullHandling.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcNullHandling.java)

2. Run demo script and check the result.
```
$ ./09-demo-jdbc-null-handling-01-show.sh
```

## Make connection sample output 
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


## Execute SQL update sample output
```
$ ./09-demo-jdbc-execute-update-01-show.sh
Connection established.
Table test.t1 created.
1 row inserted into table test.t1
1 row inserted into table test.t1
2 row inserted into table test.t1
Connection closed.
```

## Execute query sample output
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

## Transaction control sample output
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