/* source 07-demo-online-ddl-add-column-02-workload-after.sql */

/* Toggle autocommit with caution, you might create a long TX. */
/* SET @@autocommit = 0; */
/* SET @@transaction_isolation='read-committed'; */
BEGIN;
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
insert into test.target_table (name1, name2) values ('AFTER-DDL','AFTER-DDL');
COMMIT;

SELECT name1 as "|NAME1|", name2 as "|NAME2|", count(*) as "|AFTER-DDL: 1600|" 
FROM test.target_table 
GROUP BY name1, name2;
