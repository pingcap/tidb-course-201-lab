/* source 07-demo-auto-increment-01-show.sql */

/* show variables like 'auto_increment_%'; */
/* show variables like 'tidb_allow_remove_auto_inc'; */

/* Setup: the schema for attribute AUTO_INCREMENT */
DROP TABLE IF EXISTS test.t1;
CREATE TABLE test.t1 (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    from_port CHAR(4))
    AUTO_ID_CACHE 300;

DROP TABLE IF EXISTS test.t2;
CREATE TABLE test.t2 (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    from_port CHAR(4))
    AUTO_ID_CACHE 300;
