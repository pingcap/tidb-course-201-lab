"""
Version: 0.1.0
"""
from mysql.connector import connect
from mysql.connector.errors import (
    DataError,
    ProgrammingError,
    InterfaceError,
    InternalError,
)
import os


def _setup(try_char_def, try_varchar_def, try_time_f_def, try_timestamp_f_def):
    max_char_def = try_char_def
    max_varchar_def = try_varchar_def
    dyc_drop_table_stmt = """
    DROP TABLE IF EXISTS dyc
    """
    dyc_creation_ddl_stmt = """
        CREATE TABLE IF NOT EXISTS dyc (
          name varchar(100),
          max_tinytext TINYTEXT,
          max_text TEXT,
          max_mediumtext MEDIUMTEXT,
          max_longtext LONGTEXT,
          max_tinyblob TINYBLOB,
          max_blob BLOB,
          max_char CHAR({}),
          max_varchar VARCHAR({})
        )
        """
    max_time_f_def = try_time_f_def
    max_timestamp_f_def = try_timestamp_f_def
    dyt_drop_table_stmt = """
    DROP TABLE IF EXISTS dyt
    """
    dyt_creation_ddl_stmt = """
        CREATE TABLE IF NOT EXISTS dyt (
          name varchar(100),
          min_year YEAR,
          max_year YEAR,
          min_date DATE,
          max_date DATE,
          min_time TIME({}),
          max_time TIME({}),
          min_datetime DATETIME({}),
          max_datetime DATETIME({}),
          min_timestamp TIMESTAMP({}),
          max_timestamp TIMESTAMP({})
        )
        """
    # Test CHAR
    while True:
        try:
            cursor.execute(dyc_drop_table_stmt)
            ps_create_table = dyc_creation_ddl_stmt.format(
                try_char_def, try_varchar_def
            )
            cursor.execute(ps_create_table)
            max_char_def = try_char_def
            try_char_def += 1
        except ProgrammingError:  # Max CHAR length found
            break
        except InterfaceError:  # Max CHAR length found
            break
    # Test VARCHAR
    while True:
        try:
            cursor.execute(dyc_drop_table_stmt)
            ps_create_table = dyc_creation_ddl_stmt.format(
                max_char_def, try_varchar_def
            )
            cursor.execute(ps_create_table)
            max_varchar_def = try_varchar_def
            try_varchar_def += 1
        except ProgrammingError:  # Max CHAR length found
            break
        except InterfaceError:  # Max CHAR length found
            break
    # Test TIME
    while True:
        try:
            cursor.execute(dyt_drop_table_stmt)
            ps_create_table = dyt_creation_ddl_stmt.format(
                try_time_f_def,
                try_time_f_def,
                try_time_f_def,
                try_time_f_def,
                try_timestamp_f_def,
                try_timestamp_f_def,
            )
            cursor.execute(ps_create_table)
            max_time_f_def = try_time_f_def
            try_time_f_def += 1
        except ProgrammingError:  # Max Fraction length found
            break
        except InterfaceError:  # Max Fraction length found
            break
    # Test TIMESTAMP
    while True:
        try:
            cursor.execute(dyt_drop_table_stmt)
            ps_create_table = dyt_creation_ddl_stmt.format(
                max_time_f_def,
                max_time_f_def,
                max_time_f_def,
                max_time_f_def,
                try_timestamp_f_def,
                try_timestamp_f_def,
            )
            cursor.execute(ps_create_table)
            max_timestamp_f_def = try_timestamp_f_def
            try_timestamp_f_def += 1
        except ProgrammingError:  # Max Fraction length found
            break
        except InterfaceError:  # Max Fraction length found
            break
    # Final
    for ps in [
        dyc_creation_ddl_stmt.format(max_char_def, max_varchar_def),
        dyt_creation_ddl_stmt.format(
            max_time_f_def,
            max_time_f_def,
            max_time_f_def,
            max_time_f_def,
            max_timestamp_f_def,
            max_timestamp_f_def,
        ),
    ]:
        cursor.execute(ps)
    cursor.execute("SET @@tidb_mem_quota_query = 4 << 30")  # 4GB of TiDB query memory
    return (max_char_def, max_varchar_def, max_time_f_def, max_timestamp_f_def)


def _check():
    queries = [
        """SELECT
        name,
        'Max Byte vs. Max Char', 
        length(max_tinytext), char_length(max_tinytext),
        length(max_text), char_length(max_text),
        length(max_tinyblob), char_length(max_tinyblob),
        length(max_blob), char_length(max_blob),
        length(max_char), char_length(max_char),
        length(max_varchar), char_length(max_varchar) 
      FROM dyc""",
    ]
    for q in queries:
        cursor.execute(q)
        for row in cursor.fetchall():
            col1 = (
                row[0]
                if type(row[0]) is str or row[0] == None
                else row[0].decode("utf8")
            )
            col2 = (
                "(" + row[1] + "):"
                if type(row[1]) is str
                else "(" + row[1].decode("utf8") + "):"
            )
            colx = str(row[2:])
            print(
                col1,
                col2,
                colx.replace("None,", "")
                .replace("None", "")
                .replace("(", "")
                .replace(")", "")
                .replace(",", "")
                .strip(),
            )
    query_temporal = """
      SELECT
        name,
        year(min_year), year(max_year),
        min_date, max_date,
        min_time, max_time,
        min_datetime, max_datetime,
        min_timestamp, max_timestamp
      FROM dyt"""
    cursor.execute(query_temporal)
    for (
        name,
        min_year,
        max_year,
        min_date,
        max_date,
        min_time,
        max_time,
        min_datetime,
        max_datetime,
        min_timestamp,
        max_timestamp,
    ) in cursor:
        print(
            name + ":",
            " ".join(
                [
                    str(min_year),
                    str(max_year),
                    str(min_date),
                    str(max_date),
                    str(min_time),
                    str(max_time),
                    str(min_datetime),
                    str(max_datetime),
                    str(min_timestamp),
                    str(max_timestamp),
                ]
            )
            .replace("None", "")
            .strip(),
        )


def _execute_char(
    insert_statement: str, update_statement: str, meta_char: str, start_len
):
    cursor.execute(insert_statement, (meta_char * start_len,))
    conn.commit()
    max_length = start_len
    while True:
        try:
            try_length = max_length + 1
            cursor.execute(update_statement, (meta_char * try_length,))
            conn.commit()
            max_length += 1
        except DataError:  # Max length found
            break
        except InterfaceError:
            break


def _find_extreme_time_point(
    data_type: str, start_value, direction: str, dml: str, max_f_def: int
):
    deltas = [
        "INTERVAL '1' YEAR",
        "INTERVAL '1' MONTH",
        "INTERVAL '1' DAY",
        "INTERVAL '1' HOUR",
        "INTERVAL '1' MINUTE",
        "INTERVAL '1' SECOND",
    ]
    if data_type.lower() == "year":
        try_value = start_value
        while True:
            try:
                update_statement = (dml, (try_value,))
                cursor.execute(*update_statement)
                conn.commit()
                if direction == "+":
                    try_value += 1
                elif direction == "-":
                    try_value -= 1
            except DataError:  # Extreme YEAR found
                break
            except InterfaceError: # Extreme YEAR found
                break
    elif data_type.lower() == "time":
        try_value = start_value
        while True:
            try:
                update_statement = (dml, (try_value,))
                cursor.execute(*update_statement)
                conn.commit()
                seg = try_value.split(":")
                if direction == "+":
                    try_value = (
                        ":".join([str(int(seg[0]) + 1), seg[1], seg[2]])
                        + "."
                        + "9" * max_f_def
                    )
                elif direction == "-":
                    try_value = (
                        ":".join([str(int(seg[0]) - 1), seg[1], seg[2]])
                        + "."
                        + "9" * max_f_def
                    )
            except DataError:  # Extreme TIME found
                break
            except InterfaceError: # Extreme TIME found
                break
    else:
        if data_type.lower() in ["timestamp"]:
            cursor.execute("SELECT " + data_type + "('" + str(start_value) + "')")
        else:
            cursor.execute(
                "SELECT CAST('" + str(start_value) + "' as " + data_type + ")"
            )
        try_value = cursor.fetchone()[0]
        for d in deltas:
            if data_type.lower() == "date" and d in [
                "INTERVAL '1' HOUR",
                "INTERVAL '1' MINUTE",
                "INTERVAL '1' SECOND",
            ]:
                continue
            while True:
                try:
                    new_dml = (dml, (try_value,))
                    cursor.execute(*new_dml)
                    conn.commit()
                    db_value = try_value
                    f = ""
                    if data_type.lower() in ["timestamp", "datetime"]:
                        if direction == "+":
                            f = "." + "9" * max_f_def
                    if data_type.lower() in ["timestamp"]:
                        cursor.execute(
                            "SELECT "
                            + data_type
                            + "('"
                            + str(try_value)
                            + f
                            + "') "
                            + direction
                            + " "
                            + d
                        )
                    else:
                        cursor.execute(
                            "SELECT '" + str(try_value) + f + "' " + direction + " " + d
                        )
                    next_value = cursor.fetchone()[0]
                    if (
                        next_value == try_value or next_value == None
                    ):  # It hits a block or returns a warning
                        break
                    try_value = next_value
                except DataError:  # Extreme temporal found
                    try_value = db_value
                    break
                except ValueError:  # Extreme temporal found
                    try_value = db_value
                    break
                except InternalError:  # Extreme temporal found
                    cursor.fetchall()
                    try_value = db_value
                    break


def _execute_temporal(data_type: str, start_min_value, start_max_value, max_f_def):
    insert_min_statement = (
        "INSERT INTO dyt (name, min_"
        + data_type
        + ") VALUES ('"
        + data_type.upper()
        + "_MIN', %s)",
        (start_min_value,),
    )
    insert_max_statement = (
        "INSERT INTO dyt (name, max_"
        + data_type
        + ") VALUES ('"
        + data_type.upper()
        + "_MAX', %s)",
        (start_max_value,),
    )
    cursor.execute(*insert_min_statement)
    cursor.execute(*insert_max_statement)
    conn.commit()
    _find_extreme_time_point(
        data_type,
        start_min_value,
        "-",
        "UPDATE dyt SET min_"
        + data_type
        + " = %s WHERE name = '"
        + data_type.upper()
        + "_MIN'",
        max_f_def,
    )
    _find_extreme_time_point(
        data_type,
        start_max_value,
        "+",
        "UPDATE dyt SET max_"
        + data_type
        + " = %s WHERE name = '"
        + data_type.upper()
        + "_MAX'",
        max_f_def,
    )


def _year():
    _execute_temporal("year", start_min_value=10, start_max_value=2100, max_f_def=0)


def _time(max_f_def):
    _execute_temporal(
        "time",
        start_min_value="-830:59:59",
        start_max_value="830:59:59",
        max_f_def=max_f_def,
    )


def _date():
    _execute_temporal(
        "date", start_min_value="0002-01-01", start_max_value="9909-10-10", max_f_def=0
    )


def _datetime(max_f_def):
    _execute_temporal(
        "datetime",
        start_min_value="0005-03-02 00:00:01",
        start_max_value="9980-12-12 00:00:01",
        max_f_def=max_f_def,
    )


def _timestamp(max_f_def):
    _execute_temporal(
        "timestamp",
        start_min_value="1980-03-02 00:00:01",
        start_max_value="2030-01-02 00:00:01",
        max_f_def=max_f_def,
    )


def _tinytext():
    _execute_char(
        insert_statement="INSERT INTO dyc (name, max_tinytext) VALUES ('TINYTEXT', %s)",
        update_statement="UPDATE dyc SET max_tinytext = %s WHERE name = 'TINYTEXT'",
        meta_char="A",
        start_len=250,
    )


def _text():
    _execute_char(
        "INSERT INTO dyc (name, max_text) VALUES ('TEXT', %s)",
        "UPDATE dyc SET max_text = %s WHERE name = 'TEXT'",
        meta_char="A",
        start_len=65530,
    )


def _tinyblob():
    _execute_char(
        "INSERT INTO dyc (name, max_tinyblob) VALUES ('TINYBLOB', binary(%s))",
        "UPDATE dyc SET max_tinyblob = binary(%s) WHERE name = 'TINYBLOB'",
        meta_char="A",
        start_len=250,
    )


def _blob():
    _execute_char(
        "INSERT INTO dyc (name, max_blob) VALUES ('BLOB', binary(%s))",
        "UPDATE dyc SET max_blob = binary(%s) WHERE name = 'BLOB'",
        meta_char="A",
        start_len=65530,
    )


def _char(max_char_def):
    """
    Assume the default charset is utf8mb4 and client supports utf8.
    """
    _execute_char(
        "INSERT INTO dyc (name, max_char) VALUES ('CHAR("
        + str(max_char_def)
        + ")', %s)",
        "UPDATE dyc SET max_char = %s WHERE name = 'CHAR(" + str(max_char_def) + ")'",
        meta_char="𓀀",
        start_len=250,
    )


def _varchar(max_varchar_def):
    """
    Assume the default charset is utf8mb4 and client supports utf8.
    """
    _execute_char(
        "INSERT INTO dyc (name, max_varchar) VALUES ('VARCHAR("
        + str(max_varchar_def)
        + ")', %s)",
        "UPDATE dyc SET max_varchar = %s WHERE name = 'VARCHAR("
        + str(max_varchar_def)
        + ")'",
        meta_char="𓀀",
        start_len=16380,
    )


if __name__ == "__main__":

    # Get connected
    port = 4000
    tidb_host = os.getenv("TIDB_HOST", "127.0.0.1")
    tidb_username = os.getenv("TIDB_USERNAME", "root")
    tidb_password = os.getenv("TIDB_PASSWORD", "")
    conn = connect(
        database="test",
        host=tidb_host,
        port=port,
        user=tidb_username,
        password=tidb_password,
    )
    print("Connected to TiDB:", tidb_username + "@" + tidb_host + ":" + str(port))

    # The cursor
    cursor = conn.cursor(prepared=True)

    # Prepare the schema
    max_def = _setup(
        try_char_def=253, try_varchar_def=16382, try_time_f_def=6, try_timestamp_f_def=6
    )

    # Probe the limits
    _year()
    _date()
    _time(max_def[2])
    _datetime(max_def[2])
    _timestamp(max_def[3])
    _char(max_def[0])
    _varchar(max_def[1])
    _tinytext()
    _text()
    _tinyblob()
    _blob()

    # Show results
    _check()

    # Mr. Proper
    cursor.close()
    conn.close()
