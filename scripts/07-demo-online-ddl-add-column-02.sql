/* source 07-demo-online-ddl-add-column-02.sql */

/* The new column/attribute is NULL allowed */
ALTER TABLE test.target_table ADD column name2 char(40);
DESC test.target_table;
