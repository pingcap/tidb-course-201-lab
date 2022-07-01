/* source 07-demo-cluster-index-01-auto-random-cluster.sql */

/* Table t1 Clustered */
DROP TABLE IF EXISTS test.auto_random_t1_clustered;
CREATE TABLE test.auto_random_t1_clustered (
    id bigint PRIMARY KEY AUTO_RANDOM,
    id2 bigint, 
    name char(255),
    varname varchar(200));

/* Populate Seed */
INSERT INTO test.auto_random_t1_clustered (name, varname) VALUES ('A','V1'), ('B','V1'), ('C','V2'), ('D','V2');
UPDATE test.auto_random_t1_clustered SET id2=id;

/* Flooding with data 2M rows to t1 */
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;

ANALYZE table test.auto_random_t1_clustered;

/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.auto_random_t1_clustered;
/* Show information_schema for table */
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='auto_random_t1_clustered';

/* Show indexes */
SHOW INDEXES FROM test.auto_random_t1_clustered\G
/* Show regions */
SHOW TABLE test.auto_random_t1_clustered regions\G