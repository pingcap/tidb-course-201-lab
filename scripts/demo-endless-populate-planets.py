from mysql.connector import connect
from mysql.connector import Error
import time, random, datetime

db_ports = [4000, 4001, 4002]

new_planet_name = None # Variable cache
new_planet_mass = None # Variable cache

def _get_random_string(len: int) -> str:
    START = 33
    random_string = ''
    for _ in range(len):
        random_integer = random.randint(START, START+92)
        random_string += (chr(random_integer))
    return random_string

def _insert_new_planet(cursor, ps_stmt, name, mass, cat_id) -> int:
  cursor.execute( 
          ps_stmt, 
          (name, mass, 1, cat_id, datetime.datetime.now())
        )
  return cursor.lastrowid

def _print_error(err):
  print('\terrno:',err.errno)
  print('\tsqlstate:',err.sqlstate)
  print('\tmsg:',err.msg)

def _can_tolerate_dml_error(err) -> bool:
  if err.errno in [2013] and err.msg.startswith('Lost connection'): # Connection lost
    return False
  else:
    return True

def _can_tolerate_tx_error(err) -> bool:
  if err.errno in [2055] and err.msg.startswith('Lost connection'): # Connection lost
    return False
  else:
    return True

def _can_tolerate_conn_error(err) -> bool:
  if err.errno in [2013] and err.msg.startswith("Can't connect to"): # Can NOT make connection
    return True # Change to next connection
  else:
    return True # Change to next connection

def _clean(cursor, conn):
  cursor.close()
  conn.close()
  time.sleep(1)

count = -1
while True:
  try: # Make database connection scope
    count += 1
    port = db_ports[count % 3]
    conn = connect(
      database = 'universe',
      host = '127.0.0.1',
      port = port,
      user = 'root',
      password=''
    )
    print('Connected to TiDB port:',port)
    cursor = conn.cursor(prepared=True)

    ps_insert = \
      '''
      INSERT INTO `planets` (`name`, `mass`, `sun_id`, `category_id`, `discover_date`) 
      VALUES (%s, %s, %s, %s, %s)
      '''
    while True:
      time.sleep(0.5)
      try: # Cursor execute DML scope
        if new_planet_name == None and new_planet_mass == None:
          new_planet_name = _get_random_string(18)
          new_planet_mass = random.randint(1,99999)
        new_planet_category_id = random.randint(1,3)
        last_gen_id = _insert_new_planet(cursor,ps_insert,new_planet_name,new_planet_mass, new_planet_category_id)
        print('Inserting new planet: Id('+str(last_gen_id)+'), Name('+new_planet_name+'), Mass('+str(new_planet_mass)+'), Category_Id('+str(new_planet_category_id)+')')
      except Error as dml_err:
        print('DML Error:',dml_err)
        _print_error(dml_err)
        if not _can_tolerate_dml_error(dml_err):
          _clean(cursor, conn)
          break
        else:
          None # Try again
      try: # Commit the transaction scope
        print('Committing')
        conn.commit()
        new_planet_name = None # reset
        new_planet_mass = None # reset
      except Error as tx_err:
        print('TX Error:',tx_err)
        _print_error(tx_err)
        if not _can_tolerate_tx_error(tx_err):
          _clean(cursor, conn)
          break
        else:
          None # Try again
  except Error as connect_err:
    print('CONNECT Error:',connect_err)
    _print_error(connect_err)
    if not _can_tolerate_conn_error(connect_err): # The client program will exit.
      break
    _clean(cursor, conn)