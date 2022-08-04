# Go through the relevant code lines
1. Review the line #80 and line #83 in [Java class source for DemoJdbcBatchInsert.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcBatchInsert.java). The program will run twice with JDBC parameter `rewriteBatchedStatements` set to `true` and then `false`. 

```java
    ...
80:           for (String flag : new String[] { "true", "false" }) {
81:                 connection = DriverManager.getConnection(
82:                         "jdbc:mysql://" + tidbHost
83:                                + ":"+port+"/test?useServerPrepStmts=true&cachePrepStmts=true&rewriteBatchedStatements="+flag,
84:                         dbUsername, dbPassword);
    ...
```

2. Review the line #102 through line 107 in [Java class source for DemoJdbcBatchInsert.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcBatchInsert.java). Prepared statement `insert1_ps` will be added to batch for 10000 times, and be executed for once.
```java
    ...
102:                for (int i = 1; i < 10001; i++) {
103:                    insert1_ps.setInt(1, i);
104:                    insert1_ps.setString(2, Integer.toString(i));
105:                    insert1_ps.addBatch();
106:                }
107:                insert1_ps.executeBatch();
    ...
```
