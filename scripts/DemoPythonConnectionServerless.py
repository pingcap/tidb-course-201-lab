import pymysql
import sys

host, user, password = sys.argv[1], sys.argv[2], sys.argv[3]

conn = pymysql.connect(
    host=host,
    port=4000,
    user=user,
    password=password,
    database="test",
    ssl_verify_identity = True,
    ssl={
      "ca": "/etc/ssl/cert.pem"
      }
    )

with conn:
  with conn.cursor() as cursor:
    cursor.execute("SELECT DATABASE();")
    m = cursor.fetchone()
    print("Your TiDB Serverless cluster currently has the following database(s):\n" + m[0])
