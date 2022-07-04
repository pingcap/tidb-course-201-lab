# Best Practice: JDBC Batch Insert
+ Environment: `Java SDK`
+ Key points:
[Line 42, 64, 66: DemoJdbcBatchInsert.java](https://github.com/pingcap/tidb-course-201-lab/blob/master/scripts/DemoJdbcBatchInsert.java)
+ Mini Demo Story:
  + Run script to insert `10000` rows into one table with `rewriteBatchedStatements` set to `true`
  + Then, the script will do it again with `rewriteBatchedStatements` set to `false`
  + Obverse the differences on elapsed times 
```
~!@// Setup: Terminal 1 - Skip this step if you are testing on TiDB Cloud@!~
$ tiup playground v6.1.0 --tag batch-example --db 2 --pd 3 --kv 3 --tiflash 1

~!@// Demo Run: Terminal 2@!~
$ git clone https://github.com/pingcap/tidb-course-201-lab.git
$ cd tidb-course-201-lab/scripts
$ ./10-demo-jdbc-batch-insert-01-show.sh

~!@// Tear Down: Terminal 1 - Skip this step if you are testing on TiDB Cloud@!~
$ ctrl-c
$ tiup clean batch-example
```