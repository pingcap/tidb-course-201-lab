# Exercise 201.4.1: Database Connectors

## Purpose of the Exercise
+ Completed [Lab 1b: Deploying a Test Cluster](https://eng.edu.pingcap.com/unit/view/id:2467) and the TiDB cluster has been started
+ The Java SDK environment is already configured on the operating system.
+ [git](https://git-scm.com/) is already installed on the operating system.


## Steps

-----------------------------------------------
#### 1. Clone example scripts repo to local:
```
$ git clone https://github.com/pingcap/tidb-course-201-lab
```

-----------------------------------------------
#### 2. Go to working directory: `tidb-course-201-lab/scripts`:
```
$ cd tidb-course-201-lab/scripts
```

-----------------------------------------------
#### 3. Connecting and Disconnecting:
+ Sample code:
[DemoJdbcConnection.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcConnection.java)

+ Run demo script:
```
$ ./09-demo-jdbc-connection-01-show.sh
```

+ Set the `port` as 400 on line 11 in the `emoJdbcConnection.java`:
```
"jdbc:mysql://localhost:400/test", "root", ""
```

+ Run demo script again:
```
$ ./09-demo-jdbc-connection-01-show.sh
```

-----------------------------------------------
#### 4. Execute Update: 
+ Sample code:
[DemoJdbcExecuteUpdate.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteUpdate.java)

+ Run demo script:
```
$ ./09-demo-jdbc-execute-update-01-show.sh
```

-----------------------------------------------
#### 5. Execute Query:
+ Sample code:
[DemoJdbcExecuteQuery.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteQuery.java)
  + Note line 14 and line 45

+ Run demo script:
```
$ ./09-demo-jdbc-execute-query-01-show.sh
```

-----------------------------------------------
#### 6. Execute Update-tx:
+ Sample code:
[DemoJdbcExecuteUpdateTransactionControl.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcExecuteUpdateTransactionControl.java)

+  In the `DemoJdbcExecuteUpdateTransactionControl.java`, set line 52 to wrong SQL statement:
```
rowCount = statement.executeUpdate("INSERT INT t1 (name) VALUES('MNOP')");
```

+ Run demo script:
```
$ ./09-demo-jdbc-execute-update-tx-01-show.sh 
```

+ Fix SQL statement at line 52 in `DemoJdbcExecuteUpdateTransactionControl.java`:
```
rowCount = statement.executeUpdate("INSERT INTO t1 (name) VALUES('MNOP')");
```

+ Run demo script again:
```
$ ./09-demo-jdbc-execute-update-tx-01-show.sh 
```

-----------------------------------------------
#### 7. Null Handling:
+ Sample code:
[DemoJdbcNullHandling.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcNullHandling.java)
+ Note line 18, 19, 43, 47, 48


+ Run demo script:
```
$ ./09-demo-jdbc-null-handling-01-show.sh
```

## Sample Output

-----------------------------------------------
#### Step 3 Output Reference
+ successfully connect and disconnect output reference
```
$ ./09-demo-jdbc-connection-01-show.sh
Connection established.
Connection closed.
```

+ connection failed output reference
```
$ ./09-demo-jdbc-connection-01-show.sh
Error: com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure

The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.
Already disconnected.
```

-----------------------------------------------
#### Step 4 Output Reference
```
$ ./09-demo-jdbc-execute-update-01-show.sh
Connection established.
Table test.t1 created.
1 row inserted into table test.t1
1 row inserted into table test.t1
2 row inserted into table test.t1
Connection closed.
```

-----------------------------------------------
#### Step 5 Output Reference
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

-----------------------------------------------
#### Step 6 Output Reference
+ In the `DemoJdbcExecuteUpdateTransactionControl.java`, at line 52 there is wrong SQL statement
```
$ ./09-demo-jdbc-execute-update-tx-01-show.sh 
Connection established.
Turn off autocommit.
Table test.t1 created.
1 row inserted into table test.t1 (commit).
1 row inserted into table test.t1 (commit).
Error: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your TiDB version for the right syntax to use line 1 column 10 near "INT t1 (name) VALUES('MNOP')" 
SQLState: 42000
ErrorCode: 1064
Transaction rolled back.

/* Executing query: select count(*), max(id) from test.t1; */
	Row#, count(*), max(id)
	1) 2, 5188146770730811393
Turn on autocommit.
Connection closed.
```

+ Fix wrong SQL statement at line 52 in `DemoJdbcExecuteUpdateTransactionControl.java`
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
	1) 4, 5188146770730811393
Turn on autocommit.
Connection closed.
```

-----------------------------------------------
#### Step 7 Output Reference
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