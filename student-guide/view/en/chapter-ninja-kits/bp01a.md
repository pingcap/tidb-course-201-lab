# Best Practice: JDBC Batch Insert
+ Environment: `Java SDK`
+ Key points:
[Line 42, 64, 66: DemoJdbcBatchInsert.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcBatchInsert.java)
+ Mini Demo Story:
  + Inserting `10000` rows into one table with `rewriteBatchedStatements` set to `true` and `false`
```
~!@// Setup: Terminal 1 - Skip this step if you are testing on TiDB Cloud@!~
$ tiup playground v6.1.0 --tag batch-example --db 2 --pd 3 --kv 3 --tiflash 1

~!@// Demo Run@!~
$ git clone https://github.com/pingcap/tidb-course-201-lab.git
$ cd tidb-course-201-lab/scripts
$ ./10-demo-jdbc-batch-insert-01-show.sh

~!@// Tear Down: Terminal 2 - Skip this step if you are testing on TiDB Cloud@!~
$ tiup clean batch-example
```