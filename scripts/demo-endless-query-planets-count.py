from mysql.connector import connect
from mysql.connector import Error
from _mysql_connector import MySQLInterfaceError
import time

db_ports = [4000, 4001, 4002]


def _print_error(err):
    print("\terrno:", err.errno)
    print("\tsqlstate:", err.sqlstate)
    print("\tmsg:", err.msg)


def _can_tolerate_dml_error(err) -> bool:
    if err.errno in [2013] and err.msg.startswith("Lost connection"):  # Connection lost
        return False
    else:
        return True


def _can_tolerate_tx_error(err) -> bool:
    if err.errno in [2055] and err.msg.startswith("Lost connection"):  # Connection lost
        return False
    else:
        return True


def _can_telerate_conn_error(err) -> bool:
    return True  # Change to next connection


def _clean(cursor, conn):
    try:
        cursor.close()
        conn.close()
    except (Error, MySQLInterfaceError) as connect_err:
        None
    time.sleep(1)


count = -1
while True:
    try:  # Make database connection scope
        count += 1
        port = db_ports[count % 3]
        conn = connect(
            database="universe", host="127.0.0.1", port=port, user="root", password=""
        )
        print("Connected to TiDB port:", port)
        cursor = conn.cursor(prepared=True)

        ps_query = """
      SELECT count(*) as cnt, avg(mass) as max_mass
      FROM planets
      """
        while True:
            time.sleep(0.8)
            try:  # Cursor execute DML scope
                cursor.execute(ps_query)
                row = cursor.fetchone()
                if row != None:
                    print("Planets Count and Average Mass:", str(row[0]), str(row[1]))
            except Error as dml_err:
                print("Query Error:", dml_err)
                _print_error(dml_err)
                if not _can_tolerate_dml_error(dml_err):
                    _clean(cursor, conn)
                    break
                else:
                    None  # Try again
            try:  # Commit the transaction scope
                print("Committing")
                conn.commit()
                new_planet_name = None  # reset
                new_planet_mass = None  # reset
            except Error as tx_err:
                print("TX Error:", tx_err)
                _print_error(tx_err)
                if not _can_tolerate_tx_error(tx_err):
                    _clean(cursor, conn)
                    break
                else:
                    None  # Try again
    except (Error, MySQLInterfaceError) as connect_err:
        print("CONNECT Error:", connect_err)
        # _print_error(connect_err)
        if not _can_telerate_conn_error(connect_err):  # The client program will exit.
            break
        _clean(cursor, conn)
