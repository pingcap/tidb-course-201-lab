# **Lab 201.1.1b: Launch `TIDB` Database in a Container as a Lab Environment on MacOS/Windows/Linux**

## **Objective**
Deploy a sandbox TiDB cluster for the labs in this course.

## **适用场景**
+ 在支持 Docker Desktop 的环境中，快速启动 TiDB 测试容器镜像，体验 TiDB 的 SQL 接口
+ 操作系统已经支持容器，比如，已安装 Docker Desktop for [MacOS 或 Windows](https://www.docker.com/products/docker-desktop)，或 [Linux Docker Engine](https://hub.docker.com/search?offering=community&operating_system=linux&q=&type=edition)
+ 操作系统上已经安装了 [mysql client](https://cn.bing.com/search?q=MacOS+%26+Windows+mysql+client+安装) (推荐) 或 [MySQL Workbench (注意选择版本: 6.3.10，页面默认为最新高版本)](https://downloads.mysql.com/archives/workbench/) (备用)
+ 具备互联网连接

## **步骤**

****************************
#### 1. 启动 TiDB 测试集群
+ 打开终端(Windows 为 `CMD` )，出现提示符，常见的是 `$ `、`% ` (Windows 为 `盘符:\> `)
+ 使用 `pingcap/tidb` 镜像启动容器:
  ```
  $ docker run --name classroom -p 127.0.0.1:4000:4000 pingcap/tidb:latest
  ```

****************************
#### 2. 打开另一个终端，执行以下命令使用数据库客户端访问 TiDB 数据库，出现 `"mysql> "`提示符，示例中为 `"tidb> "`:
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

****************************
#### 3. 查看数据库版本:
```sql
tidb> select version();
```

****************************
#### 4. 退出数据库会话 (如有必要)
```
tidb> exit
```

****************************
#### 5. 停止测试集群:
```
$ docker stop classroom
```

****************************
#### 6. 再次启动集群:
```
$ docker start classroom
```

****************************
### 输出样例

****************************
#### 步骤1输出参考:
```
$ docker run -p 127.0.0.1:4000:4000 pingcap/tidb:v5.3.0
[2022/01/25 09:38:19.811 +00:00] [INFO] [printer.go:34] ["Welcome to TiDB."] ["Release Version"=v5.3.0] [Edition=Community]
[2022/01/25 09:38:19.812 +00:00] [INFO] [trackerRecorder.go:29] ["Mem Profile Tracker started"]
.
.
.
[2022/01/25 09:38:20.004 +00:00] [INFO] [server.go:247] ["server is running MySQL protocol"] [addr=0.0.0.0:4000]
[2022/01/25 09:38:20.004 +00:00] [INFO] [server.go:263] ["server is running MySQL protocol"] [socket=/tmp/tidb-4000.sock]
[2022/01/25 09:38:20.004 +00:00] [INFO] [http_status.go:87] ["for status and metrics report"] ["listening on addr"=0.0.0.0:10080]
[2022/01/25 09:38:20.005 +00:00] [INFO] [domain.go:1301] ["init stats info time"] ["take time"=2.078047ms]
[2022/01/25 09:38:20.005 +00:00] [INFO] [profile.go:92] ["cpu profiler started"]
```

****************************
#### 步骤3输出参考
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