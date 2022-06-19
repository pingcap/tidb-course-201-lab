# 练习 201.1.1b: 在单机 (MacOS/Linux) 环境中部署测试集群作为练习环境

## 练习目的
部署测试目的 TiDB 集群，作为本课程的练习基础。

## 前提条件
+ 互联网连接。
+ 已预先安装数据库客户端 `mycli`、 `mysql` 或 `MySQL Workbench`:
  + [mycli](https://www.mycli.net/) (推荐)
  + [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85)
  + [MySQL Workbench - 注意选择版本: 6.3.10，页面默认为最新高版本](https://downloads.mysql.com/archives/workbench/)

## 步骤

-----------------------------------------------
#### 1. 下载并安装 TiUP 工具:
+ 打开终端
  + Linux: 进入 Terminal
  + MacOS: 打开 Terminal.app
+ 执行以下命令，下载并安装 `tiup` 工具。注意 `$` 为终端提示符, 常见的也有可能是 `%`:
  ```
  $ curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
  $ export PATH=~/.tiup/bin:$PATH
  ```

-----------------------------------------------
#### 2. 启动集群 (指定各个组件的实例数量)，保持会话窗口打开:
```
$ tiup playground v6.0.0 --tag classroom --db 3 --pd 3 --kv 3 --tiflash 1
```

-----------------------------------------------
#### 3. 打开另一个终端，执行以下命令使用数据库客户端访问 TiDB 数据库，出现 `"mysql> "` 提示符:
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

+ 或者，您也可以使用 `mycli`:
  ```
  mycli mysql://root@<tidb_cloud_server_dns_name>:4000
  ```

-----------------------------------------------
#### 4. 查看数据库版本，随机数和当前时间:
```sql
select connection_id(), version(), rand(), now();
```

-----------------------------------------------
#### 5. 退出数据库会话 (如有必要)
```sql
exit
```

-----------------------------------------------
#### 6. 停止测试集群:
+ 回到第一个终端，按下 `ctrl-c` 键停掉测试集群 (请勿连续按 `ctrl-c`，一次就够了, 耐心等待终端提示符的出现，比如 `$` 或 `%`)

-----------------------------------------------
#### 7. 再次启动集群
```
$ tiup playground --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
```
