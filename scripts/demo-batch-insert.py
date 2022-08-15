"""
Version: 0.1.0
TiDB: v6.1.0
"""
from mysql.connector import connect
from mysql.connector.errors import (
    DataError,
    ProgrammingError,
    InterfaceError,
    InternalError,
    DatabaseError,
)
import os, sys, re, time


def _setup(cursor):
    sql_drop_table = "DROP TABLE IF EXISTS t1_batchtest"
    sql_create_table = (
        "CREATE TABLE t1_batchtest (pk BIGINT PRIMARY KEY AUTO_RANDOM, name CHAR(30))"
    )
    cursor.execute(sql_drop_table)
    cursor.execute(sql_create_table)


def _non_batch_style_insert(cursor, row_count):
    _setup(cursor)
    sql_insert = "INSERT INTO t1_batchtest (name) VALUES (%s)"
    b_time = time.time() * 1000
    for r in range(1, row_count + 1):
        cursor.execute(sql_insert, (r,))
    elapsed_time = time.time() * 1000 - b_time
    print("Non-Batch Inserting", row_count, "rows in", str(elapsed_time), "(ms).")


def _batch_style_insert(cursor, row_count):
    _setup(cursor)
    b_time = time.time() * 1000
    batch_values = []
    for r in range(1, row_count + 1):
        batch_values += ["('" + str(r) + "')"]
    cursor.execute("INSERT INTO t1_batchtest (name) VALUES " + ",".join(batch_values))
    elapsed_time = time.time() * 1000 - b_time
    print("Batch Inserting", row_count, "rows in", str(elapsed_time), "(ms).")


def _check_result(cursor):
    query = "SELECT count(*) FROM t1_batchtest"
    cursor.execute(query)
    for (row_count,) in cursor:
        print(f"Total rows in t1_batchtest table: {row_count}.")


if __name__ == "__main__":

    # Get connected
    port = os.getenv("TIDB_PORT", "4000")
    tidb_host = os.getenv("TIDB_HOST", "127.0.0.1")
    tidb_username = os.getenv("TIDB_USERNAME", "root")
    tidb_password = os.getenv("TIDB_PASSWORD", "")
    conn = connect(
        database="test",
        host=tidb_host,
        port=int(port),
        user=tidb_username,
        password=tidb_password,
    )
    print("Connected to TiDB:", tidb_username + "@" + tidb_host + ":" + str(port))

    # The cursor
    cursor = conn.cursor(prepared=True)

    # The SQL_MODE
    if len(sys.argv) > 2 and sys.argv[2] != None:
        print("Set SQL_MODE to:", sys.argv[2])
        cursor.execute("SET @@SQL_MODE=" + sys.argv[2])

    # Batching
    _batch_style_insert(cursor, 10000)
    conn.commit()
    _check_result(cursor)

    # Non-Batching
    _non_batch_style_insert(cursor, 10000)
    conn.commit()
    _check_result(cursor)

    # Mr. Proper
    cursor.close()
    conn.close()
