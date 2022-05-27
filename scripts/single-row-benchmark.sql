/* source single-row-benchmark.sql */

CREATE DATABASE IF NOT EXISTS test;

CREATE TABLE test.simple_table (
    id bigint PRIMARY KEY AUTO_INCREMENT,
    id2 bigint, 
    name char(255),
    varname varchar(200));

INSERT INTO test.simple_table (name, varname) VALUES ('A','V1'), ('B','V1'), ('C','V2'), ('D','V2');
UPDATE test.simple_table SET id2=id;

/* Flooding with data 2M rows to simple_table */
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;
INSERT INTO test.simple_table select null, id2, name, varname from test.simple_table;

/* Five SELECT */
SELECT * FROM test.simple_table WHERE id = 5; 
SELECT * FROM test.simple_table WHERE id = 5; 
SELECT * FROM test.simple_table WHERE id = 5; 
SELECT * FROM test.simple_table WHERE id = 5; 
SELECT * FROM test.simple_table WHERE id = 5; 
