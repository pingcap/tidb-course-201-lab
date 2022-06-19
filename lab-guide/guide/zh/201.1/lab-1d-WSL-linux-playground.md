# 练习 201.1.1d: 在单机 Windows 中安装 Windows Subsystem for Linux, 并从中启动 TiDB Playground

## 练习目的
部署测试目的 TiDB 集群，作为本课程的练习基础

## 前提条件
+ 互联网连接。
+ Windows 系统版本需要 2004 及更高版本（内部版本 19041 及更高版本）。
+ 已预先安装数据库客户端 `mycli`、 `mysql` 或 `MySQL Workbench`:
  + [mycli](https://www.mycli.net/) (推荐)
  + [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85)
  + [MySQL Workbench - 注意选择版本: 6.3.10，页面默认为最新高版本](https://downloads.mysql.com/archives/workbench/)


## 步骤

-----------------------------------------------
#### 1. 打开管理员 PowerShell 或 Windows 命令提示符安装 WSL :
```
> wsl --install
```

-----------------------------------------------
#### 2. 安装完成后重启计算机，开机后会自动进入 Ubuntu 命令行，设置您的 Ubuntu 用户为 root 并输入 `cd` 切换到 root 用户的 home:
```
> wsl --user root
> cd
```

-----------------------------------------------
#### 3. 下载并安装 mysql-client（此步骤是在 Linux 内安装 mysql-client，如果您计划在 Windows 上使用数据库客户端可以跳过这个步骤）:
```
$ apt install mysql-client-core-8.0
```

-----------------------------------------------
#### 4. 下载并安装 TiUP 工具:
```
$ curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
$ export PATH=~/.tiup/bin:$PATH
```

-----------------------------------------------
#### 5. Export 全局环境变量（一次性操作）: 
```
$ source ~/.bashrc
```

-----------------------------------------------
#### 6. 启动集群 (指定版本以及各个组件的实例数量):
```
$ tiup playground v6.0.0 --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
```

------------------------------------------------------
#### 7. 打开另一个终端（在 Linux 或 Windows 中，两者均可），执行以下命令，使用 MySQL 数据库客户端访问 TiDB 数据库，然后出现 `"mysql> "` 提示符
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

+ 或者，您也可以使用 `mycli`:
  ```
  mycli mysql://root@<tidb_cloud_server_dns_name>:4000
  ```

------------------------------------------------------
#### 8. 获得数据库版本，随机数和当前时间:
```sql
select connection_id(), version(), rand(), now();
```

------------------------------------------------------
#### 9. 退出会话 (如有必要)
```sql
exit
```
