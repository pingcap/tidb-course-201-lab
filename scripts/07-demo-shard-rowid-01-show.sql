/* source 07-demo-shard-rowid-01-show.sql */

/* SETUP */
DROP TABLE IF EXISTS test.shard_test1;
CREATE TABLE test.shard_test1 (
    id bigint,
    name varchar(30)
)
SHARD_ROW_ID_BITS = 2;

DROP TABLE IF EXISTS test.shard_test2;
CREATE TABLE test.shard_test2 (
    id bigint,
    name varchar(30)
)
SHARD_ROW_ID_BITS = 0;

INSERT INTO test.shard_test1 VALUES (1, 'TEST1');
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;
INSERT INTO test.shard_test1 SELECT * FROM test.shard_test1;

INSERT INTO test.shard_test2 VALUES (2, 'TEST2');
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;
INSERT INTO test.shard_test2 SELECT * FROM test.shard_test2;


/* Show Results */
select 'TEST1' as Result;
select count(*), max(_tidb_rowid) from test.shard_test1;
select 'TEST2' as Result;
select count(*), max(_tidb_rowid) from test.shard_test2;

/* Clean up */
DROP TABLE test.shard_test1;
DROP TABLE test.shard_test2;
