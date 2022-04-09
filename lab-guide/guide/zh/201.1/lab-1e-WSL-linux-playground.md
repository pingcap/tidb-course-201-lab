# **练习 201.1.1e: 在单机 `Windows` 中安装 `WSL` `(Ubuntu)`, 并从中启动 `TiDB Playground`**

## **目的**
部署测试目的 TiDB 集群，作为本课程的练习基础

## **适用场景**
+ Windows 系统版本需要 2004 及更高版本（内部版本 19041 及更高版本）或 Windows 11，并且可以部署测试目的 TiDB 集群
+ 具备互联网连接

## **步骤**

****************************
#### 1. 打开管理员 PowerShell 或 Windows 命令提示符安装 WSL :
```
> wsl --install
```

****************************
#### 2. 安装完成后重启计算机，开机后会自动进入 Ubuntu 命令行,设置您的 Ubuntu 用户 :
<img src="../../../diagram/WSL-settings.png" width="70%" align="top"/>

****************************
#### 3. 下载并安装 mysql-client:
```
$ apt install mysql-client-core-8.0
```

****************************
#### 4. 下载并安装 TiUP 工具:
```
$ curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
```

****************************
#### 5. 声明全局环境变量: 
```
$ source ~/.bashrc
```

****************************
#### 6. 启动集群 (指定版本以及各个组件的实例数量):
```
$ tiup playground v6.0.0 --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
```

