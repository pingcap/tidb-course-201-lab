# TiDB 数据库管理 学生实验设置指南

## 前提条件
1. 请确保您的电脑和网络可以访问端口 22，端口 2379，端口 3000.

## 电脑设置和 SSH 登陆 （Linux or macOS）
1. 您无需进行预设置。

2. 参与培训当天，实验指南会指引您下载私钥（`*.pem`），并给予私钥 `400` 的权限。例如：
   ```
   $ mv <key_file> ~/.ssh/ 
   $ chmod 400 ~/.ssh/<key_file>
   ``` 

3. 根据实验指南，连接并登陆 EC2 实例。

## 电脑设置和 SSH 登陆 （Windows）
Windows 用户可以考虑使用 Windows WSL 或终端仿真器。我们推荐 PuTTY 作为终端仿真器。下面是使用PuTTY 连接到 EC2 的说明。

1. 在您的电脑上安装 [PuTTY](https://www.putty.org/)。
   从 [PuTTY](https://www.putty.org/) 官方页面下载并安装 PuTTY。如果您已经安装了旧版本的 PuTTY，我们建议您下载最新版本。确保安装整个套件。

2. 参与培训当天，实验指南会指引你下载私钥（`*.pem`）。您需要使用 [PuTTYgen](https://www.puttygen.com/) 将私钥文件（`*.pem`）转换为 `*.ppk` 格式。

   您可以参考 AWS 官方[文档](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/connect-linux-inst-from-windows.html) 中“使用 PuTTYgen 转换私有密钥” 部分。

3. 使用 PuTTY 连接到 EC2。
   您可以参考 AWS 官方[文档](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/connect-linux-inst-from-windows.html) 中“连接到您的 Linux 实例” 部分。

## 脚本介绍
1. 成功登录 EC2 实例后（在整个课程中你使用 `monitor1` 节点作为控制机），你将看到以下提示：
      ```
      ...
      Last login: Fri Jun  2 03:56:22 2023
      [ec2-user@ip-10-0-1-33 ~]$ 
      ```

2. 实践练习的脚本位于你的主目录中，您可以运行 `ls -lF` 来验证结果：
      ```
      $ ls -lF
      total 292
      -rwxr-xr-x. 1 ec2-user ec2-user 13215 Jun  2 03:56 00-prepare-node-roles-for-user.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user    98 Jun  2 03:56 01-install-tiup.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   541 Jun  2 03:56 01-precheck-and-fix-nodes.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user    54 Jun  2 03:56 check-cluster.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user    34 Jun  2 03:56 cloud-env.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   128 Jun  2 03:56 connect-db1.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   128 Jun  2 03:56 connect-db2.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   223 Jun  2 03:56 create-cluster-v650.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   223 Jun  2 03:56 create-cluster-v651.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   114 Jun  2 03:56 destory-all.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   320 Jun  2 03:56 ff12-1.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user  1456 Jun  2 03:56 ff12-2-01-mysql-setup.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user  1096 Jun  2 03:56 ff12-2-02-tidb-setup.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user  4264 Jun  2 03:56 ff12-2-03-source-and-task-config.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   289 Jun  2 03:56 ff12-2-04-start-task.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   474 Jun  2 03:56 ff12-2-05-verify-task.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   290 Jun  2 03:56 ff13-1.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user  1646 Jun  2 03:56 ff13-2.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   587 Jun  2 03:56 ff13-3.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user    56 Jun  2 03:56 ff1.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   537 Jun  2 03:56 ff2.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user  1377 Jun  2 03:56 ff3-2.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   823 Jun  2 03:56 ff3-3.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user  1513 Jun  2 03:56 ff4.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   193 Jun  2 03:56 ff6-1.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   294 Jun  2 03:56 ff6-2.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   242 Jun  2 03:56 ff6-3.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user    56 Jun  2 03:56 ff7.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user   803 Jun  2 03:56 ff8-1.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user  1294 Jun  2 03:56 ff8-2.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user   877 Jun  2 03:59 hosts-env.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user    68 Jun  2 03:56 show-mysql-password.sh*
      -rw-r--r--. 1 ec2-user ec2-user   390 Jun  2 03:59 solution-dm-topology-six-nodes.yaml
      -rw-r--r--. 1 ec2-user ec2-user   798 Jun  2 03:59 solution-lightning-csv.toml
      -rw-r--r--. 1 ec2-user ec2-user   512 Jun  2 03:59 solution-lightning-init.toml
      -rw-r--r--. 1 ec2-user ec2-user   720 Jun  2 03:59 solution-lightning-p1.toml
      -rw-r--r--. 1 ec2-user ec2-user   720 Jun  2 03:59 solution-lightning-p2.toml
      -rw-r--r--. 1 ec2-user ec2-user   486 Jun  2 03:59 solution-lightning-sql.toml
      -rw-r--r--. 1 ec2-user ec2-user   207 Jun  2 03:59 solution-scale-out-tikv.yaml
      -rw-r--r--. 1 ec2-user ec2-user  1939 Jun  2 03:59 solution-sync-diff-config.toml
      -rw-r--r--. 1 ec2-user ec2-user   208 Jun  2 03:59 solution-three-nodes-scale-out-ticdc.yaml
      -rw-r--r--. 1 ec2-user ec2-user  4134 Jun  2 03:59 solution-tiup-meta.yaml
      -rw-r--r--. 1 ec2-user ec2-user  1788 Jun  2 03:59 solution-topology-ten-nodes.yaml
      -rwxrwxr-x. 1 ec2-user ec2-user    18 Jun  2 03:59 ssh-to-cm.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user    19 Jun  2 03:59 ssh-to-db1.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user    19 Jun  2 03:59 ssh-to-db2.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user    19 Jun  2 03:59 ssh-to-kv1.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user    18 Jun  2 03:59 ssh-to-kv2.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user    18 Jun  2 03:59 ssh-to-kv3.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user    18 Jun  2 03:59 ssh-to-monitor1.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user    18 Jun  2 03:59 ssh-to-pd1.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user    19 Jun  2 03:59 ssh-to-pd2.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user    18 Jun  2 03:59 ssh-to-pd3.sh*
      -rwxrwxr-x. 1 ec2-user ec2-user    19 Jun  2 03:59 ssh-to-tiflash1.sh*
      drwxr-xr-x. 3 ec2-user ec2-user    63 Jun  2 03:56 stage/
      -rwxr-xr-x. 1 ec2-user ec2-user    81 Jun  2 03:56 start-cluster.sh*
      -rwxr-xr-x. 1 ec2-user ec2-user    58 Jun  2 03:56 stop-cluster.sh*
      -rw-r--r--. 1 ec2-user ec2-user   487 Jun  2 03:56 template-dm-six-nodes.yaml
      -rw-r--r--. 1 ec2-user ec2-user   819 Jun  2 03:56 template-lightning-csv.toml
      -rw-r--r--. 1 ec2-user ec2-user   533 Jun  2 03:56 template-lightning-init.toml
      -rw-r--r--. 1 ec2-user ec2-user   741 Jun  2 03:56 template-lightning-p1.toml
      -rw-r--r--. 1 ec2-user ec2-user   741 Jun  2 03:56 template-lightning-p2.toml
      -rw-r--r--. 1 ec2-user ec2-user   507 Jun  2 03:56 template-lightning-sql.toml
      -rw-r--r--. 1 ec2-user ec2-user   223 Jun  2 03:56 template-scale-out-tikv.yaml
      -rw-r--r--. 1 ec2-user ec2-user  1960 Jun  2 03:56 template-sync-diff-config.toml
      -rw-r--r--. 1 ec2-user ec2-user  1935 Jun  2 03:56 template-ten-nodes.yaml
      -rw-r--r--. 1 ec2-user ec2-user   240 Jun  2 03:56 template-three-nodes-scale-out-ticdc.yaml
      -rw-r--r--. 1 ec2-user ec2-user  4281 Jun  2 03:56 template-tiup-meta.yaml
      ```

3. 本指南到此结束，请按照您的老师和实验室指南的说明完成练习。