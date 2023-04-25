/* SOURCE 07-demo-flashback-table.sql */
/* Setup */
DROP TABLE IF EXISTS TEST.R1,
TEST.R2;
CREATE TABLE TEST.R1(ID INT PRIMARY KEY);
/* Insert values into test.r1 */
INSERT INTO TEST.R1 (ID)
VALUES (1);
INSERT INTO TEST.R1 (ID)
VALUES (2);
/* Query A: Verify data in table test.r1, we are expecting COUNT 2 */
SELECT COUNT(*),
  NOW()
FROM TEST.R1;
/* Query B: Verify the GC safe point */
SELECT VARIABLE_NAME,
  VARIABLE_VALUE,
  COMMENT
FROM MYSQL.TIDB
WHERE VARIABLE_NAME = "tikv_gc_safe_point";
DROP TABLE TEST.R1;
/* Query C: ERROR 1146 is expected */
SELECT COUNT(*)
FROM TEST.R1;
/* Extract the table test.r1 and its rows from previous version to test.r2 within the GC safe-point window */
FLASHBACK TABLE TEST.R1 TO R2;
/* Query D: You can access the dropped table data from test.r2 now */
SELECT COUNT(*)
FROM TEST.R2;