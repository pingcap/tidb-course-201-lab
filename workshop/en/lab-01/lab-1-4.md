# Create a Playground sandbox on local machine by using TiUP

## Note:
+ TiUP supports Linux and macOS only.

1. Download the install `tiup` command line tool.
```
$ curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
```

2. Add `tiup` command to PATH.
```
$ source ~/.bash_profile
```

3. Set environment variables for local Playground sandbox.
```
$ export TIDB_HOST=127.0.0.1
$ export TIDB_USERNAME=root
```