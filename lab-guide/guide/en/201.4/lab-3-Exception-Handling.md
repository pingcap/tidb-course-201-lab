# Exercise 3: Exception Handling

## Prerequisites
+ You had completed one of the following execercies:
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


## Exception handling
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

5. Check the result of the two demo script.


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
