/* source 07-demo-compare-clustered-and-nonclustered-pk.sql */

/* Setup 1: Create a table with clustered PK */
DROP TABLE IF EXISTS test.auto_increment_t1_clustered;
CREATE TABLE test.auto_increment_t1_clustered (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name CHAR(255),
    varname VARCHAR(200));

/* Setup 2: Create a table with non-clustered PK */
DROP TABLE IF EXISTS test.t2_nonclustered;
CREATE TABLE test.t2_nonclustered (
    id BIGINT PRIMARY KEY NONCLUSTERED,
    name CHAR(255),
    varname VARCHAR(200));

/* Populate seed */
INSERT INTO test.auto_increment_t1_clustered (name, varname) VALUES ('A','V1'), ('B','V1'), ('C','V2'), ('D','V2');

/* Populate dummy data: Flooding with data 2M rows to t1 */
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
INSERT INTO test.auto_increment_t1_clustered SELECT null, name, varname FROM test.auto_increment_t1_clustered;
ANALYZE TABLE test.auto_increment_t1_clustered;

/* Query 1: Data in table 1 */
SELECT COUNT(DISTINCT id), COUNT(*), MIN(id), MAX(id) FROM test.auto_increment_t1_clustered;

/* Query 2: Show information_schema for table 1 */
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='auto_increment_t1_clustered';

/* Create a single row for table 2 */
INSERT INTO test.t2_nonclustered (id, name, varname) VALUES (50, 'A','V1');
ANALYZE TABLE test.auto_increment_t1_clustered;

/* Query 3: Data in table 2 */
SELECT COUNT(DISTINCT id), COUNT(*), MIN(id), MAX(id) FROM test.t2_nonclustered;

/* Query 4: Show information_schema for table 2 */
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='t2_nonclustered';

/* Query 5: Compare TiKV Regions Count */
SELECT * FROM 
(SELECT COUNT(region_id) AS "Clustered # of TiKV Regions" FROM information_schema.tikv_region_status WHERE table_name='auto_increment_t1_clustered') v1
join
(SELECT COUNT(region_id) AS "Non-Clustered # of TiKV Regions" FROM information_schema.tikv_region_status WHERE table_name='t2_nonclustered') v2;

/* Query 6: Compare the Physical Plans */
SELECT 'SELECT varname FROM test.auto_increment_t1_clustered WHERE id BETWEEN 10 AND 100;' AS "Clustered";
EXPLAIN SELECT varname FROM test.auto_increment_t1_clustered WHERE id BETWEEN 10 AND 100;
SELECT 'SELECT varname FROM test.t2_nonclustered WHERE id BETWEEN 10 AND 100;' AS "Non-Clustered";
EXPLAIN SELECT varname FROM test.t2_nonclustered WHERE id BETWEEN 10 AND 100;
