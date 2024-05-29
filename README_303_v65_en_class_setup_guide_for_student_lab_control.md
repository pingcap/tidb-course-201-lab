# TiDB Database Administration for Self-Hosted Deployments Lab Environment Setup Guide for Students

## Assumptions
1. Please ensure that your laptop and internet connection have access to port 22, port 2379, and port 3000 on the internet host.

## Laptop Setup and SSH Login (Linux or macOS)
1. No pre-configuration requited.
   
2. On the day of the training, the lab guide will direct you to download a private key file (`*.pem`) and then set its permissions to `400`. For example:
   ```
   $ mv <key_file> ~/.ssh/ 
   $ chmod 400 ~/.ssh/<key_file>
   ``` 

3. Follow the lab guide to connect to EC2 instances.

## Laptop Setup and SSH Login (Windows)
1. Install [PuTTY](https://www.putty.org/) on your computer.
   
   Download and install PuTTY from the [PuTTY](https://www.putty.org/) official page. If you already have an older version of PuTTY installed, we recommend that you download the latest version. Be sure to install the entire suite.

2. On the day of training, the lab guide will direct you to download a private key file (`*.pem`). You need to convert the private key file (`*.pem`), to `*.ppk` format using [PuTTYgen](https://www.puttygen.com/). 

   You may follow the [guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html) by AWS in the section `Convert your private key using PuTTYgen`.

5. Connect to EC2 Instance from Windows using PuTTy.

   You may follow the [guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html#putty-ssh) by AWS in the section `Connect to your Linux instance`.

## Scripts Introduction
1. After successfully logging in EC2 instance (you use `monitor1` node as the Control Machine throughout the course), you will see the following prompt:
      ```
      ...
      Last login: Fri Jun  2 03:56:22 2023
      [ec2-user@ip-10-0-1-33 ~]$ 
      ```

2. Scripts for hands-on exercises are staged at your home directory, run `ls -lF` to verify the result:
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

3. This guide stops here, follow the instructions from your instructor and the lab guide to complete the exercises. 
