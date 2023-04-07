/* source 07-demo-auto-random-01-show.sql */
/* Display all system variables related to auto_random */
/* show variables like 'allow_auto_random_explicit_insert'; */
/* Setup: The schema for attribute AUTO_RANDOM(PK_AUTO_RANDOM_BITS) */
DROP TABLE IF EXISTS test.auto_random_t1;
CREATE TABLE test.auto_random_t1 (
    id BIGINT PRIMARY KEY AUTO_RANDOM(3),
    name CHAR(255)
);
/* Populate table test.auto_random_t1 with dummy data */
INSERT INTO test.auto_random_t1 (name)
VALUES ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A'),
    ('A');
INSERT INTO test.auto_random_t1
SELECT null,
    name
FROM test.auto_random_t1;
INSERT INTO test.auto_random_t1
SELECT null,
    name
FROM test.auto_random_t1;
INSERT INTO test.auto_random_t1
SELECT null,
    name
FROM test.auto_random_t1;
INSERT INTO test.auto_random_t1
SELECT null,
    name
FROM test.auto_random_t1;
INSERT INTO test.auto_random_t1
SELECT null,
    name
FROM test.auto_random_t1;
INSERT INTO test.auto_random_t1
SELECT null,
    name
FROM test.auto_random_t1;
INSERT INTO test.auto_random_t1
SELECT null,
    name
FROM test.auto_random_t1;
INSERT INTO test.auto_random_t1
SELECT null,
    name
FROM test.auto_random_t1;
INSERT INTO test.auto_random_t1
SELECT null,
    name
FROM test.auto_random_t1;
INSERT INTO test.auto_random_t1
SELECT null,
    name
FROM test.auto_random_t1;
/* Query 1: Check the latest generated ID by function LAST_INSERT_ID(), we can not predict the value, it's random */
SELECT LAST_INSERT_ID();
/* Query 2: Check the PK_AUTO_RANDOM_BITS for test.auto_random_t1, we are expecting 4 */
SELECT TIDB_ROW_ID_SHARDING_INFO,
    TIDB_PK_TYPE
FROM information_schema.tables
WHERE table_schema = 'test'
    AND table_name = 'auto_random_t1';
/* Query 3: Count the rows group by the shard bits */
SELECT DISTINCT id << 1 >> (64 -1 -3)
FROM test.auto_random_t1;