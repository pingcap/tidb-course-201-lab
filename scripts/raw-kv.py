"""
Experimental. No production allowed.
"""
from tikv_client import RawClient
import sys
scan_begin_key = sys.argv[1]
scan_for_values = sys.argv[2:]
print('Scan start from Key:',scan_begin_key, 'Scan for:', scan_for_values)
client = RawClient.connect(['127.0.0.1:2379','127.0.0.1:2382','127.0.0.1:2384'])

found = False
scan_begin_key_bytes = scan_begin_key.encode('utf8')
while not found:
  print('Scan from key:',scan_begin_key_bytes.decode('utf8'))
  response = client.scan(scan_begin_key_bytes, b'', 10240, cf='write')
  #print(len(response), 'in this batch')
  for r in response:
    #print('Bytes KV:','K:',r[0],'V:',r[1])
    scan_begin_key_bytes = r[0]
    for value in scan_for_values:
      v = None
      try:
        v = r[1].decode('utf8')
      except UnicodeDecodeError as ex:
        try:
          v = r[1].decode('unicode_escape')
        except UnicodeDecodeError as ex:
          v = '!!!!!!!!!!!!!!!!'
      if value in v:
        print('\tFOUND!','K:',r[0].decode('unicode_escape'),'V:',r[1].decode('unicode_escape'))
        found = True