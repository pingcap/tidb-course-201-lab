# 练习 201.1.1c: 在单机 (MacOS/Windows/Linux) 环境中启动容器中的 TiDB 作为练习环境

## 练习目的
部署测试目的 TiDB 集群，作为本课程的练习基础

## 前提条件
+ 互联网连接。
+ 已预先安装数据库客户端 `mycli`、 `mysql` 或 `MySQL Workbench`:
  + [mycli](https://www.mycli.net/) (推荐)
  + [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85)
  + [MySQL Workbench - 注意选择版本: 6.3.10，页面默认为最新高版本](https://downloads.mysql.com/archives/workbench/)

## 步骤

-----------------------------------------------
#### 1. 启动 TiDB 测试集群
+ 打开终端(Windows 为 `CMD` )，出现提示符，常见的是 `$ `、`% ` (Windows 为 `盘符:\> `)
+ 使用 `pingcap/tidb` 镜像启动容器:
  ```
  $ docker run --name classroom -p 127.0.0.1:4000:4000 pingcap/tidb:latest
  ```

-----------------------------------------------
#### 2. 打开另一个终端，执行以下命令使用数据库客户端访问 TiDB 数据库，出现 `"mysql> "`提示符:
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

-----------------------------------------------
#### 3. 查看数据库版本，随机数和当前时间:
```sql
select connection_id(), version(), rand(), now();
```

-----------------------------------------------
#### 4. 退出数据库会话 (如有必要)
```sql
exit
```

-----------------------------------------------
#### 5. 停止测试集群:
```
$ docker stop classroom
```

-----------------------------------------------
#### 6. 再次启动集群:
```
$ docker start classroom
```
