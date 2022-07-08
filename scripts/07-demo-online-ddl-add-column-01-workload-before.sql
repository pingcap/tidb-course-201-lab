/* source 07-demo-online-ddl-add-column-01-workload-before.sql */

/* Toggle autocommit with caution, you might create a very long TX. */
/* SET @@autocommit = 0; */
/* SET @@transaction_isolation='read-committed'; */
/* One Error is expected. */

BEGIN;
INSERT INTO test.target_table (id, name1) SELECT NULL, name FROM test.seed;
INSERT INTO test.target_table (id, name1) SELECT NULL, name FROM test.seed;
INSERT INTO test.target_table (id, name1) SELECT NULL, name FROM test.seed;
COMMIT;
SELECT name1 as "|NAME1|", count(*) as "|BEFORE-DDL: 192000|" 
FROM test.target_table 
GROUP BY name1;
