/* source 07-demo-auto-increment-01-show.sql */

/* show variables like 'auto_increment_%'; */
/* show variables like 'tidb_allow_remove_auto_inc'; */

/* Setup the schema for attribute AUTO_INCREMENT */
DROP TABLE IF EXISTS test.t1;
CREATE TABLE test.t1 (
    id int PRIMARY KEY AUTO_INCREMENT, 
    from_port char(4));

DROP TABLE IF EXISTS test.t2;
CREATE TABLE test.t2 (
    id int PRIMARY KEY AUTO_INCREMENT, 
    from_port char(4))
    AUTO_ID_CACHE 300;

