# 练习 201.1.2: 在 TiDB 集群中创建 `universe` 数据库

## 练习目的
+ 创建 `universe` 数据库，作为本课程的练习的数据。
+ Note: `universe` 样例数据来自脚本 `universe.sql`。

## 前提条件
+ 已完成以下练习的其中任意一个:
  + 实验 `201.1.1a`
  + 实验 `201.1.1b`
  + 实验 `201.1.1c`
  + 实验 `201.1.1d`
+ 根据上述实验的步骤，确保测试用的 TiDB 集群已经启动。
+ 操作系统上已经安装 [git](https://git-scm.com/)。
+ 已预先安装数据库客户端 `mycli`、 `mysql` 或 `MySQL Workbench`:
  + [mycli](https://www.mycli.net/) (推荐)
  + [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85)
  + [MySQL Workbench - 注意选择版本: 6.3.10，页面默认为最新高版本](https://downloads.mysql.com/archives/workbench/)

## 步骤

-----------------------------------------------
#### 1. Clone 脚本示例 Repo 到本地:
```
$ git clone https://github.com/pingcap/tidb-course-201-lab
```

-----------------------------------------------
#### 2. 将工作目录切换为 `tidb-course-201-lab`:
```
$ cd tidb-course-201-lab/
```

-----------------------------------------------
#### 3. 从终端新开启一个 session 以访问 TiDB 测试数据库(本机或 TiDB Cloud):
+ a. 本地 TiDB(由练习 1b、1c、1d 或 1e 创建): 直接登录
+ 使用 mycli:
  ```
  $ mycli http://root@localhost:4000
  ``` 
+ 或使用 mysql-client:
  ```
  $ mysql -h 127.0.0.1 -P 4000 -uroot
  ```  
+ b. TiDB Cloud(由练习 1a 创建): 通过密码登录
  + 点击 TiDB Cloud 集群页面上的 `Connect` 
  + 在 `Connect to TiDB` 页面里的 `Standard Connection` 中，点击 `Add Your Current IP Address`
  + 复制列在 `Step 2: Connect with a SQL client` 下的命令，并执行
    ```
    mycli mysql://root@<tidb_cloud_server_dns_name>:4000
    ```
    ```
    mysql --connect-timeout 15 -uroot -h <tidb_cloud_server_dns_name> -P 4000 -p
    ```

-----------------------------------------------
#### 4. 导入示例 universe schema:
```sql
source scripts/universe.sql
```

-----------------------------------------------
#### 5. 检查结果 `show databases`
```sql
show databases;
```

#### 6. 检查 universe schema 里的所有的表
```sql
show tables from universe;
```

#### 7. 检查带有 `comment` 的字段
```sql
source scripts/show-universe-comments.sql;
```

-----------------------------------------------
## 输出样例

-----------------------------------------------
#### 步骤5输出参考
```sql
show databases;
```
```
+--------------------+
| Database           |
+--------------------+
| INFORMATION_SCHEMA |
| METRICS_SCHEMA     |
| PERFORMANCE_SCHEMA |
| mysql              |
| test               |
| universe           |
+--------------------+
6 rows in set (0.00 sec)
```

-----------------------------------------------
#### 步骤6输出参考
```sql
show tables from universe;
```
```
+--------------------+
| Tables_in_universe |
+--------------------+
| moons              |
| planet_categories  |
| planets            |
| stars              |
+--------------------+
4 rows in set (0.00 sec)
```

-----------------------------------------------
#### 步骤7输出参考
```sql
source scripts/show-universe-comments.sql
```
```
+----------------------+----------------+
| Stars Columns        | column_comment |
+----------------------+----------------+
| mass                 | 10**24 kg      |
| density              | kg/m**3        |
| gravity              | m/s**2         |
| escape_velocity      | km/s           |
| mass_conversion_rate | 10**6 kg/s     |
+----------------------+----------------+
5 rows in set (0.01 sec)

+---------------------+----------------+
| Planets Columns     | column_comment |
+---------------------+----------------+
| mass                | 10**24 kg      |
| diameter            | km             |
| density             | kg/m**3        |
| gravity             | m/s**2         |
| escape_velocity     | km/s           |
| rotation_period     | hours          |
| length_of_day       | hours          |
| distance_from_sun   | 10**6 km       |
| perihelion          | 10**6 km       |
| aphelion            | 10**6 km       |
| orbital_period      | days           |
| orbital_velocity    | km/s           |
| orbital_inclination | degrees        |
| obliquity_to_orbit  | degrees        |
| mean_temperature    | C              |
| surface_pressure    | bars           |
+---------------------+----------------+
16 rows in set (0.02 sec)

Empty set (0.02 sec)

+---------------+----------------+
| Moons Columns | column_comment |
+---------------+----------------+
| mass          | 10**24 kg      |
| diameter      | km             |
+---------------+----------------+
2 rows in set (0.02 sec)
```
