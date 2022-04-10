/* source 07-demo-online-ddl-add-column-02.sql */

/* NULL allowed */
alter table test.target_table add column name2 char(40);
desc test.target_table;

/* NOT NULL */
/* alter table test.target_table add column name2 char(40) NOT NULL;