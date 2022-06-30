# Best Practice: JDBC Batch Insert
+ Environment: `Java SDK`, `TiUP`
+ Mini Demo Story:
  + Create a playground 
  + Inserting `20000 rows` into one table with `rewriteBatchedStatements` set to `true` and `false`.
  + Drop the playground
```10
~!@// Setup: Terminal 1@!~
tiup playground --tag jdbc-batch-demo

~!@// Demo Run: Terminal 2@!~
$ git clone https://github.com/pingcap/tidb-course-201-lab.git
$ cd tidb-course-201-lab/scripts
$ ./10-demo-jdbc-batch-insert-01-show.sh

~!@// Tear Down: Terminal 2@!~
tiup clean jdbc-batch-demo
```