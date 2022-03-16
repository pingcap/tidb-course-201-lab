# **实验 201.1.1a: 在单机 `(MacOS/Linux)` 环境中部署测试集群作为实验环境**

## **目的**
部署测试目的 TiDB 集群，作为本课程的实验基础

## **适用场景**
+ 在 Mac 或者单机 Linux 环境快速部署 TiDB 测试集群，体验 TiDB 集群的基本架构
+ 操作系统上已经安装了 [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85) (推荐) 或 [MySQL Workbench (注意选择版本: 6.3.10，页面默认为最新高版本)](https://downloads.mysql.com/archives/workbench/) (备用)
+ 具备互联网连接

## **步骤**

****************************
#### 1. 下载并安装 `TiUP` 工具:
+ **打开终端**
  + `Linux`: 进入 `Terminal`
  + `MacOS`: 打开 `Terminal.app`
+ **执行以下命令，下载并安装 `TiUP` 工具。注意 `$` 为终端提示符, 常见的也有可能是 `%`**:
  ```
  $ curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
  $ export PATH=~/.tiup/bin:$PATH
  ```

****************************
#### 2. 启动集群 (指定各个组件的实例数量)，保持会话窗口打开:
```
$ tiup playground --tag classroom --db 3 --pd 3 --kv 3 --tiflash 1
```

****************************
#### 3. 打开另一个终端，执行以下命令使用数据库客户端访问 TiDB 数据库，出现 `"mysql> "`提示符，示例中为 `"tidb> "`:
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

****************************
#### 4. 查看数据库版本:
```sql
tidb> select version();
```

****************************
#### 5. 退出数据库会话 (如有必要)
```
exit
```

****************************
#### 6. 停止测试集群:
+ **回到第一个终端，按下 `ctrl + c` 键停掉测试集群 (请勿连续按 `ctrl + c`，一次就够了, 耐心等待终端提示符的出现，比如 `$` 或 `%`)**
  ```
  ctrl + c
  ```

****************************
#### 7. 再次启动集群
```
$ tiup playground --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
```

****************************
## **输出样例**

****************************
#### **步骤2输出参考:**
```
$ tiup playground --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
Starting component `playground`: ~/.tiup/components/playground/v1.8.2/tiup-playground v5.3.0 --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
Playground Bootstrapping...
Start pd instance
Start pd instance
Start pd instance
Start tikv instance
Start tikv instance
Start tikv instance
Start tidb instance
Start tidb instance
Waiting for tidb instances ready
127.0.0.1:4000 ... Done
127.0.0.1:4001 ... Done
Start tiflash instance
Waiting for tiflash instances ready
127.0.0.1:3930 ... Done
CLUSTER START SUCCESSFULLY, Enjoy it ^-^
To connect TiDB: mysql --comments --host 127.0.0.1 --port 4001 -u root -p (no password)
To connect TiDB: mysql --comments --host 127.0.0.1 --port 4000 -u root -p (no password)
To view the dashboard: http://127.0.0.1:2379/dashboard
PD client endpoints: [127.0.0.1:2379 127.0.0.1:2382 127.0.0.1:2384]
To view the Prometheus: http://127.0.0.1:9090
To view the Grafana: http://127.0.0.1:3000
```

****************************
#### 步骤4输出参考:
```sql
tidb> select version();
```
```
+--------------------+
| version()          |
+--------------------+
| 5.7.25-TiDB-v5.3.0 |
+--------------------+
1 row in set (0.00 sec)
```

#### 步骤6输出参考:
```
^CPlayground receive signal:  interrupt
Got signal interrupt (Component: playground ; PID: 7497)
Wait tiflash(7514) to quit...
Grafana quit
prometheus quit
pd quit
pd quit
ng-monitoring quit
tiflash quit
Wait tidb(7505) to quit...
pd quit
tidb quit
Wait tidb(7504) to quit...
tidb quit
Wait tikv(7503) to quit...
tikv quit
Wait tikv(7502) to quit...
tikv quit
Wait tikv(7501) to quit...
tikv quit
Wait pd(7500) to quit...
Wait pd(7499) to quit...
Wait pd(7498) to quit...
$
```