/* source 07-demo-flashback-query.sql */

/* Setup */
DROP TABLE IF EXISTS test.fbq;
CREATE TABLE test.fbq (id int PRIMARY KEY);

/* Insert values into test.fbq */
INSERT INTO test.fbq (id) VALUES (1);

/* Query 1: Check data in table test.fbq, we are expecting id=1 */
SELECT id, 'Current data' FROM test.fbq;

/* Query 2: Apply certain waiting, do nothing for 5 seconds */
SELECT SLEEP(5);

/* Update the ID column for the only row in test.fbq table to 2 from 1 */
UPDATE test.fbq SET id=2 WHERE id=1;

/* Query 3: Check data in table test.fbq, we are expecting id=2 */
SELECT id FROM test.fbq;

/* Query 4: Check the data in table test.fbq from 3 seconds ago, we are expecting id=1 instead of 2 */
SELECT id, 'Data from the past' FROM test.fbq AS OF TIMESTAMP(CURRENT_TIMESTAMP() - INTERVAL '3' SECOND);

/* Query 5: Check the default GC life time window size, we are expecting 10 minutes and 0 seconds */
show variables like 'tidb_gc_life_time';

/* Query 6: Check the data in table test.fbq beyond the GC safe point window, error code 9006 is expected */
SELECT id FROM test.fbq AS OF TIMESTAMP(CURRENT_TIMESTAMP() - INTERVAL '1' HOUR);

