"""
Version: 0.1.0
TiDB: v6.1.0
"""
from tikv_client import RawClient

if __name__ == "__main__":

    # Get connected
    ports = ["127.0.0.1:2379", "127.0.0.1:2382", "127.0.0.1:2384"]
    c = RawClient.connect(ports)
    print("put(b'Key1',b'Value1')")
    c.put(b"Key1", b"Value1")
    print("get(b'Key1'):", c.get(b"Key1"))
    print("get(b'Key0'):", c.get(b"Key0"))
