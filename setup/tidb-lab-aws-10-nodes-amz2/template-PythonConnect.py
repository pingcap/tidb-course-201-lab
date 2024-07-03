import mysql.connector

conn = mysql.connector.connect(
    database="test",
    host="<HOST_DB1_PRIVATE_IP>",
    port=4000,
    user="root",
    password="",
)
cursor = conn.cursor()
query = "SELECT tidb_version();"
cursor.execute(query)
for ans in cursor:
    print(ans)
cursor.close()
conn.close()
