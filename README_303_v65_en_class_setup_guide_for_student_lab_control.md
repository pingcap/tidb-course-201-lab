# TiDB Database Administration for Self-Hosted Deployments Lab Environment Setup Guide for Students

## Assumptions
1. Please ensure that your laptop and internet connection have access to port 22, port 2379, and port 3000 on the internet host.

## Laptop Setup and SSH Login (Linux or macOS)
1. No pre-configuration required.
   
2. On the day of the training, the lab guide will direct you to download a private key file (`*.pem`) and then set its permissions to `400`. For example:
   ```
   $ mv <key_file> ~/.ssh/ 
   $ chmod 400 ~/.ssh/<key_file>
   ``` 

3. Follow the lab guide to connect to EC2 instances.

## Laptop Setup and SSH Login (Windows)
Windows users can consider using the Windows WSL or a terminal emulator. PuTTY is the recommended terminal emulator. Instructions for using PuTTY to connect to EC2 are provided below.  

1. Install [PuTTY](https://www.putty.org/) on your computer.
   
   Download and install PuTTY from the [PuTTY](https://www.putty.org/) official page. If you already have an older version of PuTTY installed, we recommend that you download the latest version. Be sure to install the entire suite.

2. On the day of training, the lab guide will direct you to download a private key file (`*.pem`). You need to convert the private key file (`*.pem`), to `*.ppk` format using [PuTTYgen](https://www.puttygen.com/). 

   You may follow the [guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-linux-inst-from-windows.html) by AWS in the section `Convert your private key using PuTTYgen`.

3. Connect to EC2 Instance from Windows using PuTTY.

   You may follow the [guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-linux-inst-from-windows.html) by AWS in the section `Connect to your Linux instance`.

4. This guide stops here, follow the instructions from your instructor and the lab guide to complete the exercises. 
