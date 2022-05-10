# **练习 201.1.2: 在 TiDB 集群中创建 `universe` 数据库**

## **目的**
+ 创建 `universe` 数据库，作为本课程的练习的数据基础
+ **Note**: `universe` 样例数据库来自 `universe.sql`

## 前提条件
+ 已完成一下练习的其中一个:
  + [练习 201.1.1a](lab-1a-native-playground.md)
  + [练习 201.1.1b](lab-1b-container-tidb.md)
  + [练习 201.1.1c](lab-1c-vm-linux-playground.md)
  + [练习 201.1.1d](lab-1d-tidb-cloud-dev-tier.md)
  + [练习 201.1.1e](lab-1e-WSL-linux-playground.md)

## **适用场景**
+ `TiDB` 集群已启动
+ 操作系统上已经安装了 [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85) (推荐) 或 [MySQL Workbench (注意选择版本: 6.3.10，页面默认为最新高版本)](https://downloads.mysql.com/archives/workbench/) (备用)
+ 操作系统上已经安装了 [git client](https://cn.bing.com/search?q=MacOS++Windows+Linux+git+%E5%AE%89%E8%A3%85&qs=n&form=QBRE&sp=-1&pq=macos+windows+linux+git+%E5%AE%89%E8%A3%85&sc=0-26&sk=&cvid=E653925A950F4E0DA9290FB191F883D1)

## **步骤**

-----------------------------------------------
#### 1. Clone 示例库到本地:
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
+ a. 本地 TiDB(由练习 1a、1b、1c 或 1e 创建): 直接登录
  ```
  $ mysql -h 127.0.0.1 -P 4000 -uroot
  ``` 
+ b. TiDB Cloud(由练习 1d 创建): 通过密码登录
  + 点击 TiDB Cloud 集群页面上的 `Connect` 
  + 在 `Connect to TiDB` 页面里的 `Standard Connection` 中，点击 `Add Your Current IP Address`
  + 复制列在 `Step 2: Connect with a SQL client` 下的命令，并执行
    ```
    mysql --connect-timeout 15 -uroot -h <tidb_cloud_server_dns_name> -P 4000 -p
    ```

-----------------------------------------------
#### 4. 导入示例 schema - universe:
```sql
source scripts/universe.sql
```

-----------------------------------------------
#### 5. 检查结果 - databases
```sql
show databases;
```

#### 6. 检查结果 - tables
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

-----------------------------------------------***
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

-----------------------------------------------***
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
