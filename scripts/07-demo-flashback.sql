/* source 07-demo-flashback.sql */

/* target_table(id, name1) */
DROP TABLE IF EXISTS test.r1, test.r2;
CREATE TABLE test.r1(id int PRIMARY KEY);

/* insert values into test.r1 */
INSERT INTO test.r1 (id) VALUES (1);
INSERT INTO test.r1 (id) VALUES (2);

SELECT COUNT(*), NOW() FROM test.r1;

/* check gc safe point test.r1 */
SELECT * FROM mysql.tidb WHERE variable_name = "tikv_gc_safe_point";

DROP TABLE test.r1;

SELECT COUNT(*), NOW() FROM test.r1;

FLASHBACK TABLE test.r1 TO r2;

SELECT COUNT(*) FROM test.r2;

