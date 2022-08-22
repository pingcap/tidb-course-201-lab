# Exercise 3: Exception Handling

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

3. If you have TiDB Cloud Developer Tier and you prefer to do the exercise on a Cloud node like Amazon EC2, please jump to *Section 3: Try it out on TiDB Cloud*


## Section 2: Exception handling
1. Go through the sample code -[DemoJdbcPreparedStatementOnlineDDL.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcPreparedStatementOnlineDDL.java)


2. Run demo script and check the result.
```
$ ./11-demo-jdbc-prepared-statement-online-ddl-01-show.sh
```

3. Run demo script again.
```
$ ./11-demo-jdbc-prepared-statement-online-ddl-01-show.sh
```

4. When demo script starts executing query, open another terminal and run another demo script.
```
$ ./07-demo-online-ddl-add-column-02-workload-after.sh
```

5. Compare the difference between two runs of `./11-demo-jdbc-prepared-statement-online-ddl-01-show.sh`. Try to find out why the second time you run the demo script, there is an error, but the final output is the same as the first time.

## Section 3: Try it out on TiDB Cloud
1. Until now, our exercises are targeting local TiDB Playground cluster. If you completed the [TiDB Architecture Basics Exercise 1a](https://eng.edu.pingcap.com/unit/view/id:2466), you can change the target database to TiDB Cloud Developer Tier. 
	+ Note: Each subsequent step requires you to do it on a practice node in the same Cloud Provider Region (e.g: Amazon EC2 instance) as your TiDB Cloud Developer Tier. Otherwise, the response latency may suffer. 

2. For exception handling, locate JDBC URL "jdbc:mysql://localhost:4000/test", "root", "") in [DemoJdbcPreparedStatementOnlineDDL.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcPreparedStatementOnlineDDL.java) under the `scripts` folder on your practice node, change the `hostname`, `port`, `username` and `password` to corresponding values provided by your TiDB Cloud Developer Tier. And then, run the script.
```
$ ./11-demo-jdbc-prepared-statement-online-ddl-01-show.sh
```

## Exception handling sample output
```
$ ./11-demo-jdbc-prepared-statement-online-ddl-01-show.sh
Connection established.
preparing
preparing
preparing
preparing
preparing
populating
populating
populating
populating
populating
populating

/* Executing query: select count(*) as "|320|" from test.seed; */
	Row#, |320|
	1) 320

/* Executing query: DESC test.target_table; */
	Row#, Field, Type
	1) id, bigint(20)
	2) name1, char(20)
Main stream workload ...0
Main stream workload commit ...

/* Executing query: SELECT name1 as "|NAME1|", count(*) as "|BEFORE-DDL: 192000|" FROM test.target_table GROUP BY name1 ORDER BY 1; */
	Row#, name1, |BEFORE-DDL: 192000|
	1) BEFORE-DDL, 960
Main stream workload ...1
Main stream workload commit ...

(Omit intermediate output)

/* Executing query: SELECT name1 as "|NAME1|", count(*) as "|BEFORE-DDL: 192000|" FROM test.target_table GROUP BY name1 ORDER BY 1; */
	Row#, name1, |BEFORE-DDL: 192000|
	1) BEFORE-DDL, 192000
I: 199
Turn on autocommit.
Connection closed.
```

```
% ./11-demo-jdbc-prepared-statement-online-ddl-01-show.sh
Connection established.
preparing
preparing
preparing
preparing
preparing
populating
populating
populating
populating
populating
populating

/* Executing query: select count(*) as "|320|" from test.seed; */
	Row#, |320|
	1) 320

/* Executing query: DESC test.target_table; */
	Row#, Field, Type
	1) id, bigint(20)
	2) name1, char(20)
Main stream workload ...0
Main stream workload commit ...

(Omit intermediate output)

/* Executing query: SELECT name1 as "|NAME1|", count(*) as "|BEFORE-DDL: 192000|" FROM test.target_table GROUP BY name1 ORDER BY 1; */
	Row#, name1, |BEFORE-DDL: 192000|
	1) BEFORE-DDL, 111360
Main stream workload ...116
Main stream error.
Error: java.sql.SQLException: Information schema is changed during the execution of the statement(for example, table definition may be updated by other DDL ran in parallel). If you see this error often, try increasing `tidb_max_delta_schema_count`. [try again later]
SQLState: HY000
ErrorCode: 8028
java.sql.SQLException: Information schema is changed during the execution of the statement(for example, table definition may be updated by other DDL ran in parallel). If you see this error often, try increasing `tidb_max_delta_schema_count`. [try again later]
	at com.mysql.jdbc.SQLError.createSQLException(SQLError.java:998)
	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3847)
	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3783)
	at com.mysql.jdbc.MysqlIO.sendCommand(MysqlIO.java:2447)
	at com.mysql.jdbc.MysqlIO.sqlQueryDirect(MysqlIO.java:2594)
	at com.mysql.jdbc.ConnectionImpl.execSQL(ConnectionImpl.java:2541)
	at com.mysql.jdbc.ConnectionImpl.commit(ConnectionImpl.java:1612)
	at DemoJdbcPreparedStatementOnlineDDL.main(DemoJdbcPreparedStatementOnlineDDL.java:93)
8028 encountered, backoff...
Main stream workload ...116
Main stream workload commit ...

(Omit intermediate output)

/* Executing query: SELECT name1 as "|NAME1|", count(*) as "|BEFORE-DDL: 192000|" FROM test.target_table GROUP BY name1 ORDER BY 1; */
	Row#, name1, |BEFORE-DDL: 192000|
	1) AFTER-DDL, 1600
	2) BEFORE-DDL, 192000
I: 199
Turn on autocommit.
Connection closed.
```

```
% ./07-demo-online-ddl-add-column-02-workload-after.sh
Field	Type	Null	Key	Default	Extra
id	bigint(20)	NO	PRI	NULL	
name1	char(20)	YES		NULL	
name2	char(40)	YES		NULL	
|NAME1|	|NAME2|	|AFTER-DDL: 1600|
BEFORE-DDL	NULL	111360
AFTER-DDL	AFTER-DDL	16
|NAME1|	|NAME2|	|AFTER-DDL: 1600|
AFTER-DDL	AFTER-DDL	32
BEFORE-DDL	NULL	111360

(Omit intermediate output)

AFTER-DDL	AFTER-DDL	1568
|NAME1|	|NAME2|	|AFTER-DDL: 1600|
AFTER-DDL	AFTER-DDL	1584
BEFORE-DDL	NULL	139200
|NAME1|	|NAME2|	|AFTER-DDL: 1600|
AFTER-DDL	AFTER-DDL	1600
BEFORE-DDL	NULL	140160
```
