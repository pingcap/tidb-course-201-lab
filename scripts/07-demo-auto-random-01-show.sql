/* source 07-demo-auto-random-01-show.sql */

/* Display all system variables related to auto_random */

/* show variables like 'allow_auto_random_explicit_insert'; */

/* Setup the schema for attribute AUTO_RANDOM(PK_AUTO_RANDOM_BITS) */

DROP TABLE IF EXISTS test.auto_random_t1;
CREATE TABLE test.auto_random_t1 (
    id bigint PRIMARY KEY AUTO_RANDOM(4),
    name char(255));

/* Populate Seed */
INSERT INTO test.auto_random_t1 (name) VALUES ('A');
INSERT INTO test.auto_random_t1 (name) VALUES ('B');
INSERT INTO test.auto_random_t1 (name) VALUES ('C');
INSERT INTO test.auto_random_t1 (name) VALUES ('D');
INSERT INTO test.auto_random_t1 (name) VALUES ('E');
INSERT INTO test.auto_random_t1 (name) VALUES ('F');
INSERT INTO test.auto_random_t1 (name) VALUES ('G');
INSERT INTO test.auto_random_t1 (name) VALUES ('H');
INSERT INTO test.auto_random_t1 (name) VALUES ('I');
INSERT INTO test.auto_random_t1 (name) VALUES ('J');
INSERT INTO test.auto_random_t1 (name) VALUES ('K');
INSERT INTO test.auto_random_t1 (name) VALUES ('L');
INSERT INTO test.auto_random_t1 (name) VALUES ('M');
INSERT INTO test.auto_random_t1 (name) VALUES ('N');
INSERT INTO test.auto_random_t1 (name) VALUES ('O');
INSERT INTO test.auto_random_t1 (name) VALUES ('P');
INSERT INTO test.auto_random_t1 (name) VALUES ('Q');
INSERT INTO test.auto_random_t1 (name) VALUES ('R');
INSERT INTO test.auto_random_t1 (name) VALUES ('S');
INSERT INTO test.auto_random_t1 (name) VALUES ('T');
INSERT INTO test.auto_random_t1 (name) VALUES ('U');
INSERT INTO test.auto_random_t1 (name) VALUES ('V');
INSERT INTO test.auto_random_t1 (name) VALUES ('W');
INSERT INTO test.auto_random_t1 (name) VALUES ('X');
INSERT INTO test.auto_random_t1 (name) VALUES ('Y');
INSERT INTO test.auto_random_t1 (name) VALUES ('Z');
INSERT INTO test.auto_random_t1 (name) VALUES ('a');
INSERT INTO test.auto_random_t1 (name) VALUES ('b');
INSERT INTO test.auto_random_t1 (name) VALUES ('c');
INSERT INTO test.auto_random_t1 (name) VALUES ('d');
INSERT INTO test.auto_random_t1 (name) VALUES ('e');
INSERT INTO test.auto_random_t1 (name) VALUES ('f');
INSERT INTO test.auto_random_t1 (name) VALUES ('g');
INSERT INTO test.auto_random_t1 (name) VALUES ('h');
INSERT INTO test.auto_random_t1 (name) VALUES ('i');
INSERT INTO test.auto_random_t1 (name) VALUES ('j');
INSERT INTO test.auto_random_t1 (name) VALUES ('k');
INSERT INTO test.auto_random_t1 (name) VALUES ('l');
INSERT INTO test.auto_random_t1 (name) VALUES ('m');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');
INSERT INTO test.auto_random_t1 (name) VALUES ('x1');

/* Check last_insert_id() */
SELECT LAST_INSERT_ID();

/* Greetings to CBO */
ANALYZE TABLE test.auto_random_t1;

/* select 'test.auto_random_t1' as Title; */

/* desc test.auto_random_t1; */
select TIDB_ROW_ID_SHARDING_INFO, TIDB_PK_TYPE 
from information_schema.tables 
where table_schema='test' 
and table_name='auto_random_t1';

/* check value */
SELECT substr(cast(id as CHAR),1,2) as id_prefix, count(*) as approx_rows_in_shard
FROM test.auto_random_t1
GROUP BY id_prefix
HAVING approx_rows_in_shard > 1
ORDER BY id_prefix;

/*SHOW TABLE test.auto_random_t1 REGIONS\G*/
