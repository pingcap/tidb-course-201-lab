# **练习 201.1.1c: 在单机 (MacOS/Windows/Linux) 环境中启动容器中的 TiDB 作为练习环境**

## **目的**
部署测试目的 TiDB 集群，作为本课程的练习基础

## **前提条件**
+ 在支持 Docker Desktop 的环境中，快速启动 TiDB 测试容器镜像，体验 TiDB 的 SQL 接口
+ 操作系统已经支持容器，比如，已安装 Docker Desktop for [MacOS 或 Windows](https://www.docker.com/products/docker-desktop)，或 [Linux Docker Engine](https://hub.docker.com/search?offering=community&operating_system=linux&q=&type=edition)
+ 操作系统上已经安装了 [mysql client](https://cn.bing.com/search?q=MacOS+%26+Windows+mysql+client+安装) (推荐) 或 [MySQL Workbench (注意选择版本: 6.3.10，页面默认为最新高版本)](https://downloads.mysql.com/archives/workbench/) (备用)
+ 具备互联网连接

## **步骤**

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
select version(), rand(), now();
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
