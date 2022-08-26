import pkgutil
import mysql.connector

conn = mysql.connector.connect(
    database="test",
    host="127.0.0.1",
    port=4000,
    user="root",
    password="",
)
cursor = conn.cursor()
query_setup = "CREATE TABLE IF NOT EXISTS t1 (pk INT, name CHAR(30))"
query_insert = "INSERT INTO t1 (pk, name) VALUES (%(pk)s, %(name)s)"
cursor.execute(query_setup)
cursor.execute(query_insert, {"pk": 2, "name": "DEF"})
conn.commit()
print ("1 row inserted into table test.t1")
cursor.close()
conn.close()