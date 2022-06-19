# 实验 201.1.3 (可选): 使用 `mycli` 连接到 TiDB 集群

## 练习目的
+ `mycli` 是一种 MySQL 命令行工具，相较于其他 MySQL 命令行工具，`mycli` 具备两个特点：一个是提示并自动补全 SQL 语句，另一个是语法高亮。对于 SQL 语句不熟练的同学可以极大提高使用体验，学习速度。

## 前提条件
+ TiDB 集群已启动，并完成了 **实验 201.1.2: 在 TiDB 集群中创建 `universe` 数据库**。
+ 互联网连接。

## 步骤

-----------------------------------------
#### 1. 安装 `mycli` 
+ a. 在终端直接安装 mycli
  ```
  $ sudo apt install mycli
  ``` 
+ b. 使用 pip（要求安装 python） 安装 mycli
    ```
    sudo pip install mycli
    ```

-----------------------------------------
#### 2. 从终端新开启一个 session 使用 mycli 访问 TiDB 测试数据库
  ```
  $ mycli mysql://root@localhost:4000
  ``` 
