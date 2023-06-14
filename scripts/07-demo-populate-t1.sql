/* SOURCE 07-demo-populate-t1.sql */
/* Populate dummy data */
/* B1 */
INSERT INTO test.t1 (rid, gid)
VALUES (FLOOR(1 + RAND() * 90000000), 0);
/* B2 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B3 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B4 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B5 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B6 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B7 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B8 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B9 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B10 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B11 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B12 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B13 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B14 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B15 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B16 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B17 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B18 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B19 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
/* B20 */
INSERT INTO test.t1 (rid, gid)
SELECT FLOOR(1 + RAND() * 90000000),
    gid + 1
FROM test.t1;
ANALYZE TABLE test.t1;