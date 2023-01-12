/* source 07-demo-partition-hash-01-show.sql */

/* Setup: Create a hash partitioned table t1 */
DROP TABLE IF EXISTS test.t1;
CREATE TABLE test.t1 (x INT)
    PARTITION BY HASH(x)
    PARTITIONS 4;

/* Populate dummy data */
INSERT INTO test.t1 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
INSERT INTO test.t1 SELECT * FROM test.t1;
ANALYZE TABLE test.t1;

/* Query 1: Check partition point queries with equi predicate */
EXPLAIN SELECT * FROM test.t1 where x=0;
EXPLAIN SELECT * FROM test.t1 where x=2;
EXPLAIN SELECT * FROM test.t1 where x=9;

/* Query 2: Check multiple partitions query with range preficate */
EXPLAIN SELECT * FROM test.t1 where x between 7 and 9;
