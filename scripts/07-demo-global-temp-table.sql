/* source 07-demo-global-temp-table.sql */

/* create a global temporary table */
DROP TABLE IF EXISTS test.temp2;
CREATE GLOBAL TEMPORARY TABLE test.temp2 (id BIGINT);
CREATE GLOBAL TEMPORARY TABLE test.temp2 (id BIGINT) ON COMMIT DELETE ROWS;

/* set autocommit to off */
SET @@autocommit = 'OFF';

/* insert data into the global temporary table */
INSERT INTO test.temp2 VALUES (10);

/* check the data in the global temporary table */
SELECT * FROM test.temp2;

COMMIT;

/* check the data in the global temporary table again */
SELECT * FROM test.temp2;

/* check the global temporary table */
SHOW CREATE TABLE test.temp2;
