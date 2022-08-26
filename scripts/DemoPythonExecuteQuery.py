import mysql.connector

conn = mysql.connector.connect(
    database="test",
    host="127.0.0.1",
    port=4000,
    user="root",
    password="",
)
cursor = conn.cursor()
query = "SELECT pk, name FROM t1 WHERE pk between %s and %s"
start_idx = 1
end_idx = 10
cursor.execute(
    query,
    (
        start_idx,
        end_idx,
    ),
)
for (pk, name) in cursor:
    print(f"PK of {name} is {pk}")
cursor.close()
conn.close()
