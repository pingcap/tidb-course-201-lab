from mysql.connector import connect

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
        length(max_tinytext), char_length(max_tinytext),
        length(max_text), char_length(max_text),
        length(max_tinyblob), char_length(max_tinyblob),
        length(max_blob), char_length(max_blob),
        length(max_char), char_length(max_char),
        length(max_varchar), char_length(max_varchar) 
      FROM dyc"""
  )
  for row in cursor.fetchall():
    print(row)

def _tinytext(name: str):
  max_length = 255
  cursor.execute( 
            "INSERT INTO dyc (name, max_tinytext) VALUES (%s, %s)",
            (name, "我"*max_length)
          )
  conn.commit()

def _text(name: str):
  max_length = 65535
  cursor.execute( 
            "INSERT INTO dyc (name, max_text) VALUES (%s, %s)",
            (name, "我"*max_length)
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
_tinytext("TINYTEXT")
_text("TEXT")
_tinyblob("TINYBLOB")
_blob("BLOB")
_char("CHAR")
_varchar("VARCHAR")
_check()

cursor.close()
conn.close()