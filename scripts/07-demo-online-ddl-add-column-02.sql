/* source 07-demo-online-ddl-add-column-02.sql */

/* NULL allowed */
ALTER TABLE test.target_table ADD column name2 char(40);
DESC test.target_table;
