# **实验 3: 使用 mycli 连接到TiDB 集群并在 `universe` 数据库中做简单查询**

## **目的**
+ mycli 是一种 MYSQL 命令行工具，相较于其他 MYSQL 命令行工具，mycli 具备两个特点：一个是提示并自动补全 SQL 语句，另一个是语法高亮。对于 SQL 语句不熟练的同学可以极大提高使用体验，学习速度。

## **适用场景**
+ `TiDB` 集群已启动，并完成了 `实验 2: 在 TiDB 集群中创建 `universe` 数据库`
+ 具备互联网连接。

## **步骤**
****************************
#### 1. 安装 mycli 
+ a. 在终端直接安装 mycli
  ```
  $ sudo apt install mycli
  ``` 
+ b. 使用 pip（要求安装 python） 安装 mycli
    ```
    sudo pip install mycli
    ```

****************************
#### 2. 从终端新开启一个 session 使用 mycli 访问 TiDB 测试数据库
  ```
  $ mycli mysql://root@localhost:4000
  ``` 

****************************
#### 3. 利用 mycli 的特点，完成下面 SQL 语句
+ a.导入示例 schema - universe（如已完成实验2，可跳过此步）:
```sql
tidb> source universe.sql
```

+ b.检查结果 - databases
```sql
tidb> show databases;
```

+ c.选取使用 `universe` 数据库
```sql
tidb> use universe;
```

+ d.查询 `地球` 的 `质量、直径、重力`
```sql
tidb> SELECT name,mass,diameter,gravity FROM planets WHERE name='Earth';
```
****************************
## 输出样例

****************************
#### 步骤3.b输出参考
```sql
tidb> show databases;
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
****************************
#### 步骤3.d输出参考
```sql
tidb> SELECT name,mass,diameter,gravity FROM planets WHERE name='Earth';
```
```
+--------+--------+------------+-----------+
| name   |   mass |   diameter |   gravity |
|--------+--------+------------+-----------|
| Earth  |   5.97 |      12756 |       9.8 |
+--------+--------+------------+-----------+
1 row in set
```