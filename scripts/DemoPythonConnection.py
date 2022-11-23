import mysql.connector

conn = mysql.connector.connect(
    database="test", host="127.0.0.1", port=4000, user="root", password=""
)
print(
    f"Connected to {conn.server_host}:{conn.server_port} "
    f"as {conn.user} (Connection ID: {conn.connection_id})"
)
print(f"The server is running {conn.get_server_info()}")
conn.close()
