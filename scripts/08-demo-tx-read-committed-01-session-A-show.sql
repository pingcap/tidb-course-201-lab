/* source 08-demo-tx-read-committed-01-session-A-show.sql */

SET @@autocommit = 0;

DROP TABLE IF EXISTS test.t1;
CREATE TABLE test.t1 (
  id int primary key auto_random,
  name char(10) 
);

INSERT INTO test.t1 VALUES (NULL, 'A');
