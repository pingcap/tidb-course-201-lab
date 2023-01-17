/* source demo-timezone.sql */

DROP TABLE IF EXISTS test.T;

-- Query the global and session timezone 
SELECT @@GLOBAL.TIME_ZONE, @@SESSION.TIME_ZONE;

/* Query two timezone related functions */
SELECT NOW();
SELECT CURTIME();

/* Create a table T with two columns, the type of the first column is one is DATETIME, and the other is TIMESTAMP */
USE TEST;
CREATE TABLE T(A DATETIME, B TIMESTAMP);
INSERT INTO T VALUES(NOW(), NOW());
SELECT * FROM T;

/* Change the session timezone to UTC */
SET SESSION TIME_ZONE='UTC';

/* Query the global and session timezone */
SELECT @@GLOBAL.TIME_ZONE, @@SESSION.TIME_ZONE;
SELECT * FROM T;

/* Query two timezone related functions */
SELECT NOW();
SELECT CURTIME();