import mysql.connector

conn = mysql.connector.connect(
    database="test",
    host="127.0.0.1",
    port=4000,
    user="root",
    password="",
)
cursor = conn.cursor(prepared=True)
query_setup = (
    "CREATE TABLE IF NOT EXISTS t2 (pk BIGINT AUTO_RANDOM PRIMARY KEY, name CHAR(30))"
)
query_insert = "INSERT INTO t2 (name) VALUES (%(name)s)"
cursor.execute(query_setup)
cursor.execute(query_insert, ({"name": "ABC"}))
print("Generated PK is", cursor.lastrowid)
conn.commit()
cursor.close()
conn.close()