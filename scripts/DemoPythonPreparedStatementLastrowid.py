import mysql.connector

conn = mysql.connector.connect(
    database="test",
    host="127.0.0.1",
    port=4000,
    user="root",
    password="",
)
cursor = conn.cursor(prepared=True)
query_clean = "DROP TABLE IF EXISTS demo_py_ps_lstid"
query_setup = "CREATE TABLE IF NOT EXISTS demo_py_ps_lstid (pk BIGINT AUTO_RANDOM PRIMARY KEY, name CHAR(30))"
query_insert = "INSERT INTO demo_py_ps_lstid (name) VALUES (%s)"
cursor.execute(query_clean)
cursor.execute(query_setup)
cursor.execute(query_insert, ("ABC",))
print("The generated PK is", cursor.lastrowid)
conn.commit()
cursor.close()
conn.close()
