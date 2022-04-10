/* source 07-demo-online-ddl-add-column-01-workload-before.sql */

/* Toggle autocommit with caution, you might create a long TX. */
SET @@autocommit = 0;
/* SET @@transaction_isolation='read-committed'; */
/* One Error is expected. */

insert into test.target_table (id, name1) select null, name from test.seed;
commit;
select name1, count(*) from test.target_table group by name1;
