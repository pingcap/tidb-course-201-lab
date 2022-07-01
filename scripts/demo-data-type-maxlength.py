from mysql.connector import connect
from mysql.connector.errors import DataError as ex

port = 4000
conn = connect(
  database = 'test',
  host = '127.0.0.1',
  port = port,
  user = 'root',
  password=''
)
print('Connected to TiDB port:',port)
cursor = conn.cursor(prepared=True)

def _setup():
  ps_drop_table = \
    '''
    DROP TABLE IF EXISTS dyc
    '''
  ps_create_table = \
    '''
    CREATE TABLE IF NOT EXISTS dyc (
      name varchar(100),
      max_tinytext TINYTEXT,
      max_text TEXT,
      max_mediumtext MEDIUMTEXT,
      max_longtext LONGTEXT,
      max_tinyblob TINYBLOB,
      max_blob BLOB,
      max_char CHAR(255),
      max_varchar VARCHAR(16383)
    )
    '''
  
  cursor.execute(ps_drop_table)
  cursor.execute(ps_create_table)
  cursor.execute('SET @@tidb_mem_quota_query = 4 << 30') # 4GB of TiDB query memory

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
    print(row[0].decode('utf8'),"("+row[1].decode('utf8')+"):", str(row[2:]).replace('None,','').replace('None','').replace('(','').replace(')','').replace(',','').strip())

def _execute_char(insert_statement: str, update_statement: str, meta_char: str, start_len):
  cursor.execute(
            "INSERT INTO dyc (name, max_tinytext) VALUES ('TINYTEXT', %s)",
            ("A"*255)
          )
  conn.commit()
  max_length = start_len
  while True:
    max_length += 1
    cursor.execute(
      update_statement,
      (meta_char*max_length)
    )
    conn.commit()

def _tinytext():
  _execute_char(
            insert_statement="INSERT INTO dyc (name, max_tinytext) VALUES ('TINYTEXT', %s)",
            update_statement="UPDATE dyc SET max_tinytext = %s WHERE name = 'TINYTEXT'",
            meta_char="A",
            start_len=254
          )

def _text(name: str):
  max_length = 65535
  cursor.execute( 
            "INSERT INTO dyc (name, max_text) VALUES (%s, %s)",
            (name, "A"*max_length)
          )
  conn.commit()

def _tinyblob(name: str):
  max_length = 255
  cursor.execute( 
            "INSERT INTO dyc (name, max_tinyblob) VALUES (%s, binary(%s))",
            (name, "A"*max_length)
          )
  conn.commit()

def _blob(name: str):
  max_length = 65535
  cursor.execute( 
            "INSERT INTO dyc (name, max_blob) VALUES (%s, binary(%s))",
            (name, "A"*max_length)
          )
  conn.commit()

def _char(name: str):
  max_length = 255
  cursor.execute( 
            "INSERT INTO dyc (name, max_char) VALUES (%s, %s)",
            (name, "我"*max_length)
          )
  conn.commit()

def _varchar(name: str):
  max_length = 16383
  cursor.execute( 
            "INSERT INTO dyc (name, max_varchar) VALUES (%s, %s)",
            (name, "我"*max_length)
          )
  conn.commit()

_setup()
_tinytext()
_text("TEXT")
_tinyblob("TINYBLOB")
_blob("BLOB")
_char("CHAR(255)")
_varchar("VARCHAR(16383)")
_check()

cursor.close()
conn.close()