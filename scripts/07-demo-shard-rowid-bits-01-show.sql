/* source 07-demo-shard-rowid-bits-01-show.sql */

/* Setup the schema for option SHARD_ROW_ID_BITS */

DROP TABLE IF EXISTS test.shard_rb;
CREATE TABLE test.shard_rb (
    id bigint,
    name char(255)
) SHARD_ROW_ID_BITS = 4;

/* Populate Seed */
INSERT INTO test.shard_rb (name) VALUES ('A');
INSERT INTO test.shard_rb (name) VALUES ('B');
INSERT INTO test.shard_rb (name) VALUES ('C');
INSERT INTO test.shard_rb (name) VALUES ('D');
INSERT INTO test.shard_rb (name) VALUES ('E');
INSERT INTO test.shard_rb (name) VALUES ('F');
INSERT INTO test.shard_rb (name) VALUES ('G');
INSERT INTO test.shard_rb (name) VALUES ('H');
INSERT INTO test.shard_rb (name) VALUES ('I');
INSERT INTO test.shard_rb (name) VALUES ('J');
INSERT INTO test.shard_rb (name) VALUES ('K');
INSERT INTO test.shard_rb (name) VALUES ('L');
INSERT INTO test.shard_rb (name) VALUES ('M');
INSERT INTO test.shard_rb (name) VALUES ('N');
INSERT INTO test.shard_rb (name) VALUES ('O');
INSERT INTO test.shard_rb (name) VALUES ('P');
INSERT INTO test.shard_rb (name) VALUES ('Q');
INSERT INTO test.shard_rb (name) VALUES ('R');
INSERT INTO test.shard_rb (name) VALUES ('S');
INSERT INTO test.shard_rb (name) VALUES ('T');
INSERT INTO test.shard_rb (name) VALUES ('U');
INSERT INTO test.shard_rb (name) VALUES ('V');
INSERT INTO test.shard_rb (name) VALUES ('W');
INSERT INTO test.shard_rb (name) VALUES ('X');
INSERT INTO test.shard_rb (name) VALUES ('Y');
INSERT INTO test.shard_rb (name) VALUES ('Z');
INSERT INTO test.shard_rb (name) VALUES ('a');
INSERT INTO test.shard_rb (name) VALUES ('b');
INSERT INTO test.shard_rb (name) VALUES ('c');
INSERT INTO test.shard_rb (name) VALUES ('d');
INSERT INTO test.shard_rb (name) VALUES ('e');
INSERT INTO test.shard_rb (name) VALUES ('f');
INSERT INTO test.shard_rb (name) VALUES ('g');
INSERT INTO test.shard_rb (name) VALUES ('h');
INSERT INTO test.shard_rb (name) VALUES ('i');
INSERT INTO test.shard_rb (name) VALUES ('j');
INSERT INTO test.shard_rb (name) VALUES ('k');
INSERT INTO test.shard_rb (name) VALUES ('l');
INSERT INTO test.shard_rb (name) VALUES ('m');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');
INSERT INTO test.shard_rb (name) VALUES ('x1');

/* Greetings to CBO */
ANALYZE table test.shard_rb;

select 'test.shard_rb' as Title;

desc test.shard_rb;
select TIDB_ROW_ID_SHARDING_INFO, TIDB_PK_TYPE 
from information_schema.tables 
where table_schema='test' 
and table_name='shard_rb';

/* check value */
SELECT substr(cast(_tidb_rowid as CHAR),1,2) as id_prefix, count(*) as approx_rows_in_shard
FROM test.shard_rb
GROUP BY id_prefix
HAVING approx_rows_in_shard > 1
ORDER BY id_prefix;

SHOW TABLE test.shard_rb REGIONS\G
