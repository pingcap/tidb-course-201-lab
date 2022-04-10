/* source 07-demo-online-ddl-add-column-02-workload-after.sql */

/* Toggle autocommit with caution, you might create a long TX. */
SET @@autocommit = 0;
SET @@transaction_isolation='read-committed';
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
commit;
select name1, name2, count(*) from test.target_table group by name1, name2;
