/* source 11-demo-table-01-setup.sql */
/* Setup the schema for CLUSTERED vs. NONCLUSTERED primary keys */
/* Ensure the replica setting */
SET CONFIG PD replication.max-replicas = 3;
/* Table t1: Clustered */
DROP TABLE IF EXISTS test.p;
DROP TABLE IF EXISTS test.c;
/* Table p will contain 524288 rows */
CREATE TABLE test.p (
    pid INT PRIMARY KEY AUTO_INCREMENT,
    insert_batch_id INT NOT NULL,
    charname CHAR(100) NOT NULL,
    varname VARCHAR(30) NOT NULL
);
/* Table c will contain 8388608 rows */
CREATE TABLE test.c (
    cid INT PRIMARY KEY AUTO_INCREMENT,
    pid INT NOT NULL,
    insert_batch_id INT NOT NULL,
    charname CHAR(100) NOT NULL,
    varname VARCHAR(30) NOT NULL
);
/* Populate test.p */
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
VALUES (NULL, 0, 'A', 'W'),
    (NULL, 0, 'B', 'X'),
    (NULL, 0, 'C', 'Y'),
    (NULL, 0, 'D', 'Z');
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
INSERT INTO test.p (pid, insert_batch_id, charname, varname)
SELECT NULL,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.p;
/* Populate test.c */
INSERT INTO test.c (cid, pid, insert_batch_id, charname, varname)
SELECT NULL,
    pid,
    0,
    charname,
    varname
FROM test.p;
INSERT INTO test.c (cid, pid, insert_batch_id, charname, varname)
SELECT NULL,
    pid,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.c;
INSERT INTO test.c (cid, pid, insert_batch_id, charname, varname)
SELECT NULL,
    pid,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.c;
INSERT INTO test.c (cid, pid, insert_batch_id, charname, varname)
SELECT NULL,
    pid,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.c;
INSERT INTO test.c (cid, pid, insert_batch_id, charname, varname)
SELECT NULL,
    pid,
    LAST_INSERT_ID(),
    charname,
    varname
FROM test.c;
/* CBO */
ANALYZE TABLE test.p;
ANALYZE TABLE test.c;
/* Ouptut Rows Count */
SELECT COUNT(*)
FROM test.p;
SELECT COUNT(*)
FROM test.c;