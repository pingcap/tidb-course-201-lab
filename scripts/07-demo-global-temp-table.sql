/* source 07-demo-global-temp-table.sql */

/* Setup: Create a global temporary table */
DROP TABLE IF EXISTS test.temp2, test.perm3;

/* Create global temporary table attempt 1, fail with error code 1064 */
CREATE GLOBAL TEMPORARY TABLE test.temp2 (id BIGINT);

/* Create global temporary table attempt 2 */
CREATE GLOBAL TEMPORARY TABLE test.temp2 (id BIGINT) ON COMMIT DELETE ROWS;

/* Turn off autocommit for current session */
SET @@autocommit = 'OFF';

/* Insert data into the global temporary table */
INSERT INTO test.temp2 VALUES (10);

/* Query 1: Check the data in the global temporary table, expecting 10 */
SELECT * FROM test.temp2;

/* Manual commit, the data is cleared */
COMMIT;

/* Query 2: Check the data in the global temporary table again */
SELECT * FROM test.temp2;

/* Create a permanent table */
CREATE TABLE test.perm3 (id BIGINT);

/* Create global temporary table attempt 3, error code 1050 is expected */
CREATE GLOBAL TEMPORARY TABLE test.perm3 (id BIGINT) ON COMMIT DELETE ROWS;

