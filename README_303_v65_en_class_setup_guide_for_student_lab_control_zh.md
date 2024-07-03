# TiDB 数据库管理 学生实验设置指南

## 前提条件
1. 请确保您的电脑和网络可以访问端口 22，端口 2379，端口 3000.

## 电脑设置和 SSH 登录 （Linux or macOS）
1. 您无需进行预设置。

2. 参与培训当天，实验指南会指引您下载私钥（`*.pem`），并给予私钥 `400` 的权限。例如：
   ```
   $ mv <key_file> ~/.ssh/ 
   $ chmod 400 ~/.ssh/<key_file>
   ``` 

3. 根据实验指南，连接并登录 EC2 实例。

## 电脑设置和 SSH 登录 （Windows）
Windows 用户可以考虑使用 Windows WSL 或终端仿真器。我们推荐 PuTTY 作为终端仿真器。下面是使用PuTTY 连接到 EC2 的说明。

1. 在您的电脑上安装 [PuTTY](https://www.putty.org/)。
   从 [PuTTY](https://www.putty.org/) 官方页面下载并安装 PuTTY。如果您已经安装了旧版本的 PuTTY，我们建议您下载最新版本。确保安装整个套件。

2. 参与培训当天，实验指南会指引你下载私钥（`*.pem`）。您需要使用 [PuTTYgen](https://www.puttygen.com/) 将私钥文件（`*.pem`）转换为 `*.ppk` 格式。

   您可以参考 AWS 官方[文档](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/connect-linux-inst-from-windows.html) 中“使用 PuTTYgen 转换私有密钥” 部分。

3. 使用 PuTTY 连接到 EC2。
   您可以参考 AWS 官方[文档](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/connect-linux-inst-from-windows.html) 中“连接到您的 Linux 实例” 部分。

4. 本指南到此结束，请按照您的老师和实验室指南的说明完成练习。