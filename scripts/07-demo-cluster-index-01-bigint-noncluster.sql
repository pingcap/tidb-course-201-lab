/* source 07-demo-cluster-index-01-bigint-noncluster.sql */

/* Table t3 Clustered */
DROP TABLE IF EXISTS test.bigint_t3_nonclustered;
CREATE TABLE test.bigint_t3_nonclustered (
    id bigint PRIMARY KEY NONCLUSTERED,
    id2 bigint, 
    name char(255),
    varname varchar(200));

/* Copy from other */
INSERT INTO test.bigint_t3_nonclustered SELECT * FROM test.auto_increment_t2_clustered;
ANALYZE table test.bigint_t3_nonclustered;

/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.bigint_t3_nonclustered;
/* Show information_schema for table */
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='bigint_t3_nonclustered';

/* Show indexes */
/*SHOW INDEXES FROM test.bigint_t3_nonclustered\G*/
/* Show regions */
SHOW TABLE test.bigint_t3_nonclustered regions\G

EXPLAIN SELECT varname FROM test.bigint_t3_nonclustered WHERE id between 10 and 100;