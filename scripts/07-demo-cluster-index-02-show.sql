/* source 07-demo-cluster-index-02-show.sql */

/* Compare the execution plans with CLUSTERED and NONCLUSTERED primary keys table */

/* Index_and_Region 1 */
select 'Table test.auto_random_t1_clustered' as Index_and_Region;
/* Show indexes */
select 'Table test.auto_random_t1_clustered' as Indexes;
SHOW INDEXES FROM test.auto_random_t1_clustered\G
/* Show regions */
select 'Table test.auto_random_t1_clustered' as Regions;
SHOW TABLE test.auto_random_t1_clustered regions\G

/* Index_and_Region 2 */
select 'Table test.t2_nonclustered' as Index_and_Region;
/* Show indexes */
select 'Table test.t2_nonclustered' as Indexes;
SHOW INDEXES FROM test.t2_nonclustered\G
/* Show regions */
select 'Table test.t2_nonclustered' as Regions;
SHOW TABLE test.t2_nonclustered regions\G

/* Index_and_Region 3 */
select 'Table test.t3_nonclustered' as Index_and_Region;
/* Show indexes */
select 'Table test.t3_nonclustered' as Indexes;
SHOW INDEXES FROM test.t3_nonclustered\G
/* Show regions */
select 'Table test.t3_nonclustered' as Regions;
SHOW TABLE test.t3_nonclustered regions\G

/* Index_and_Region 4 */
select 'Table test.t4_clustered' as Index_and_Region;
/* Show indexes */
select 'Table test.t4_clustered' as Indexes;
SHOW INDEXES FROM test.t4_clustered\G
/* Show regions */
select 'Table test.t4_clustered' as Regions;
SHOW TABLE test.t4_clustered regions\G

/* Index_and_Region 5 */
select 'Table test.t5_nonclustered' as Index_and_Region;
/* Show indexes */
select 'Table test.t5_nonclustered' as Indexes;
SHOW INDEXES FROM test.t5_nonclustered\G
/* Show regions */
select 'Table test.t5_nonclustered' as Regions;
SHOW TABLE test.t5_nonclustered regions\G

/* Index_and_Region 6 Composite */
select 'Table test.t6_nonclustered' as Index_and_Region;
/* Show indexes */
select 'Table test.t6_nonclustered' as Indexes;
SHOW INDEXES FROM test.t6_nonclustered\G
/* Show regions */
select 'Table test.t6_nonclustered' as Regions;
SHOW TABLE test.t6_nonclustered regions\G

/* Index_and_Region 7 Composite */
select 'Table test.t7_clustered' as Index_and_Region;
/* Show indexes */
select 'Table test.t7_clustered' as Indexes;
SHOW INDEXES FROM test.t7_clustered\G
/* Show regions */
select 'Table test.t7_clustered' as Regions;
SHOW TABLE test.t7_clustered regions\G

/* Execution Plan PointGet */
select 'select * from test.auto_random_t1_clustered where id=32471241834;' as "PointGet";
select "CLUSTETED" as Explain_t1;
explain select * from test.auto_random_t1_clustered where id=32471241834;
select "NONCLUSTETED" as Explain_t2;
explain select * from test.t2_nonclustered where id=32471241834;
select "NONCLUSTETED" as Explain_t3;
explain select * from test.t3_nonclustered where id='32471241834';
select "CLUSTETED" as Explain_t4;
explain select * from test.t4_clustered where id='32471241834';
select "NONCLUSTETED" as Explain_t5;
explain select * from test.t5_nonclustered where id=32471241834;
select "NONCLUSTETED" as Explain_t6;
explain select * from test.t6_nonclustered where id=32471241834 and id2=32471241834;
select "CLUSTETED" as Explain_t7;
explain select * from test.t7_clustered where id=32471241834 and id2=32471241834;

/* Execution Plan Range */
select 'select * from test.auto_random_t1_clustered where id between 1230 and 1232;' as "Range Scan";
select "CLUSTETED" as Explain_t1;
explain select * from test.auto_random_t1_clustered where id between 1230 and 1232;
select "NONCLUSTETED" as Explain_t2;
explain select * from test.t2_nonclustered where id between 1230 and 1232;
select "NONCLUSTETED" as Explain_t3;
explain select * from test.t3_nonclustered where id between '1230' and '1232';
select "CLUSTETED" as Explain_t4;
explain select * from test.t4_clustered where id between '1230' and '1232';
select "NONCLUSTETED" as Explain_t5;
explain select * from test.t5_nonclustered where id between 1230 and 1232;
select "NONCLUSTETED" as Explain_t6;
explain select * from test.t6_nonclustered where id between 1230 and 1232;
select "CLUSTETED" as Explain_t7;
explain select * from test.t7_clustered where id between 1230 and 1232;

/* _tidb_rowid */
select 'test.auto_random_t1_clustered' as "_tidb_rowid";
select _tidb_rowid from test.auto_random_t1_clustered limit 1;
select min(_tidb_rowid), max(_tidb_rowid), count(*) from test.auto_random_t1_clustered;

select 'test.t2_nonclustered' as "_tidb_rowid";
select _tidb_rowid from test.t2_nonclustered limit 1;
select min(_tidb_rowid), max(_tidb_rowid), count(*) from test.t2_nonclustered;

select 'test.t3_nonclustered' as "_tidb_rowid";
select _tidb_rowid from test.t3_nonclustered limit 1;
select min(_tidb_rowid), max(_tidb_rowid), count(*) from test.t3_nonclustered;

select 'test.t4_clustered' as "_tidb_rowid";
select _tidb_rowid from test.t4_clustered limit 1;
select min(_tidb_rowid), max(_tidb_rowid), count(*) from test.t4_clustered;

select 'test.t5_nonclustered' as "_tidb_rowid";
select _tidb_rowid from test.t5_nonclustered limit 1;
select min(_tidb_rowid), max(_tidb_rowid), count(*) from test.t5_nonclustered;

select 'test.t6_nonclustered composite' as "_tidb_rowid";
select _tidb_rowid from test.t6_nonclustered limit 1;
select min(_tidb_rowid), max(_tidb_rowid), count(*) from test.t6_nonclustered;

select 'test.t7_clustered composite' as "_tidb_rowid";
select _tidb_rowid from test.t7_clustered limit 1;
select min(_tidb_rowid), max(_tidb_rowid), count(*) from test.t7_clustered;
