from mysql.connector import connect
from mysql.connector.errors import DataError, ProgrammingError, InterfaceError

def _setup(try_char_def, try_varchar_def):
    ps_drop_table = """
    DROP TABLE IF EXISTS dyc
    """
    max_char_def = try_char_def
    max_varchar_def = try_varchar_def
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
    # Test CHAR
    while True:
        try:
            cursor.execute(ps_drop_table)
            ps_create_table = dyc_creation_ddl_stmt.format(
                try_char_def, try_varchar_def
            )
            cursor.execute(ps_create_table)
            max_char_def = try_char_def
            try_char_def += 1
        except ProgrammingError or InterfaceError:  # Max CHAR length found
            break
    # Test VARCHAR
    while True:
        try:
            cursor.execute(ps_drop_table)
            ps_create_table = dyc_creation_ddl_stmt.format(
                max_char_def, try_varchar_def
            )
            cursor.execute(ps_create_table)
            max_varchar_def = try_varchar_def
            try_varchar_def += 1
        except ProgrammingError or InterfaceError:  # Max VARCHAR length found
            break
    # Final
    ps_create_table = dyc_creation_ddl_stmt.format(max_char_def, max_varchar_def)
    cursor.execute(ps_create_table)
    cursor.execute("SET @@tidb_mem_quota_query = 4 << 30")  # 4GB of TiDB query memory
    return (max_char_def, max_varchar_def)


def _check():
    cursor.execute(
        """SELECT
        name,
        'Length in Byte vs. Length in Char', 
        length(max_tinytext), char_length(max_tinytext),
        length(max_text), char_length(max_text),
        length(max_tinyblob), char_length(max_tinyblob),
        length(max_blob), char_length(max_blob),
        length(max_char), char_length(max_char),
        length(max_varchar), char_length(max_varchar) 
      FROM dyc"""
    )
    for row in cursor.fetchall():
        print(
            row[0].decode("utf8"),
            "(" + row[1].decode("utf8") + "):",
            str(row[2:])
            .replace("None,", "")
            .replace("None", "")
            .replace("(", "")
            .replace(")", "")
            .replace(",", "")
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
            cursor.execute(update_statement, (meta_char * try_length,))  #
            conn.commit()
            max_length += 1
        except DataError:  # Max length found
            break


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
    port = 4000
    conn = connect(
        database="test", host="127.0.0.1", port=port, user="root", password=""
    )
    print("Connected to TiDB port:", port)
    cursor = conn.cursor(prepared=True)
    max_def = _setup(try_char_def=253, try_varchar_def=16382)
    _char(max_def[0])
    _varchar(max_def[1])
    _tinytext()
    _text()
    _tinyblob()
    _blob()
    _check()

    # Mr. Proper
    cursor.close()
    conn.close()
