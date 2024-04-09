import mysql.connector
import random
from datetime import datetime
import sys

conn = mysql.connector.connect(
    database="emp",
    host="<HOST_DB1_PRIVATE_IP>",
    port=4000,
    user="userA",
    password="",
)
cursor = conn.cursor()

t1 = datetime.now()

for i in range(int(sys.argv[1])):
    salary = random.randint(100, 10000)
    query = (
        "update emp.sal set salary="
        + str(salary)
        + " where emp_no between 10001 and 40000;"
    )
    cursor.execute(query)
    conn.commit()

t2 = datetime.now()
delta = t2 - t1
print("Running time", delta)


cursor.close()
conn.close()
