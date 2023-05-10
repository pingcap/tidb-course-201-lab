# Course TiDB Administration Class Setup Guide for Students [v6.5]

## Exercises Nodes Information
You will receive a table from your instructor that describes the exercise environment before each hands-on exercise. Such as the following, assume that you are assigned as `user2`:
      
      | Instance ID         | Public IP    | Private IP  | Name    | Instructor | Student | Role     | Up Time (mins) |
      | :------------------ | :----------- | :---------- | :------ | :--------- | :------ | :------- | :------------- |
      | i-08151997dd939a6bd | 54.xx.xx.70  | 10.90.2.209 | db      | gXXXXXXXo  | user1   | db1      | 3              |
      | i-093c618d76e4e5b25 | 52.xx.xx.15  | 10.90.3.6   | db      | gXXXXXXXo  | user1   | db2      | 3              |
      | i-095a704ff26b8e4cf | 34.xx.xx.47  | 10.90.3.86  | kv      | gXXXXXXXo  | user1   | kv1      | 2              |
      | i-015057ecff55e09b5 | 34.xx.xx.38  | 10.90.1.84  | kv      | gXXXXXXXo  | user1   | kv2      | 2              |
      | i-056f185f8bfdfd293 | 35.xx.xx.198 | 10.90.2.253 | kv      | gXXXXXXXo  | user1   | kv3      | 2              |
      | i-0bb0553841ecc0451 | 35.xx.xx.55  | 10.90.4.220 | monitor | gXXXXXXXo  | user1   | monitor1 | 3              |
      | i-0823a3a917d5bf87f | 35.xx.xx.193 | 10.90.1.124 | pd      | gXXXXXXXo  | user1   | pd1      | 3              |
      | i-0bd3492919928e185 | 35.xx.xx.248 | 10.90.2.124 | pd      | gXXXXXXXo  | user1   | pd2      | 3              |
      | i-01847bab040690d96 | 34.xx.xx.209 | 10.90.3.168 | pd      | gXXXXXXXo  | user1   | pd3      | 3              |
      | i-04d8f0c4345244f51 | 34.xx.xx.183 | 10.90.4.74  | tiflash | gXXXXXXXo  | user1   | tiflash1 | 3              |

## Assumptions
1. Please ensure that your laptop and internet connection have access to port 22 on the internet host.

## Laptop Setup and SSH Login (Linux or macOS)
1. You will receive a private key file, `*.pem`, from your instructor, make sure the permission is set to `400`.
      ```
      $ mv <key_file> ~/.ssh/ 
      $ chmod 400 ~/.ssh/<key_file>
      ``` 

2. Connect to your EC2 instance, using the following commands with `SSH` forward enabled. The example is using the `monitor1` node as the login target:
    ```
    $ ssh-add  ~/.ssh/<key_file>
    $ ssh -A ec2-user@34.220.83.xx
    ```

## Laptop Setup and SSH Login (Windows)
1. Install [PuTTY](https://www.putty.org/) on your computer.
   
   Download and install PuTTY from the [PuTTY](https://www.putty.org/) official page. If you already have an older version of PuTTY installed, we recommend that you download the latest version. Be sure to install the entire suite.

2. Convert the private key file (`*.pem`), from your instructor, to `*.ppk` format using [PuTTYgen](https://www.puttygen.com/). 

   You may follow the [guide]((https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html)) by AWS in the section `Convert your private key using PuTTYgen`.

3. Configure the key-quartermaster.
   + Open `Pageant` from the start menu. (Note: it may run off to the system tray)
   + Click `Add Key` to include the key in `*.ppk` format.

4. Connect to EC2 Instance from Windows using PuTTy.

   Make sure that you also allow the agent SSH forwarding in PuTTY (See the image below. It might be slightly different from yours due to software versions).

   <img src="./ninja-kits/diagram/PuttyAllowAgentForwarding_aa_001_20230109.png" width="50%" align="top"/>

## Scripts Introduction
1. After successfully logging in EC2 instance (you use `monitor1` node as the Control Machine throughout the course), you will see the following prompt:
      ```
      Last login: Sat Jan 28 09:24:36 2023 from 120.204.xx.xx

          __|  __|_  )
          _|  (     /   Amazon Linux 2 AMI
         ___|\___|___|

      https://aws.amazon.com/amazon-linux-2/
      [ec2-user@ip-10-0-1-33 ~]$ 
      ```

2. Scripts for hands-on exercises are staged at your home directory, run `ls -lF` to verify the result:
      ```
      $ ls -lF
      total 268
      -rwxr-xr-x 1 ec2-user ec2-user 12476 May  9 23:59 00-prepare-node-roles-for-user.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   505 May  9 23:59 01-precheck-and-fix-nodes.sh*
      -rwxr-xr-x 1 ec2-user ec2-user    54 May  9 23:59 check-cluster.sh*
      -rwxr-xr-x 1 ec2-user ec2-user    29 May  9 23:59 cloud-env.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   128 May  9 23:59 connect-db1.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   128 May  9 23:59 connect-db2.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   205 May  9 23:59 create-cluster-v650.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   205 May  9 23:59 create-cluster-v651.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   114 May  9 23:59 destory-all.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   309 May  9 23:59 ff12-1.sh*
      -rwxr-xr-x 1 ec2-user ec2-user  1456 May  9 23:59 ff12-2-01-mysql-setup.sh*
      -rwxr-xr-x 1 ec2-user ec2-user  1096 May  9 23:59 ff12-2-02-tidb-setup.sh*
      -rwxr-xr-x 1 ec2-user ec2-user  4215 May  9 23:59 ff12-2-03-source-and-task-config.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   275 May  9 23:59 ff12-2-04-start-task.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   474 May  9 23:59 ff12-2-05-verify-task.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   288 May  9 23:59 ff13-1.sh*
      -rwxr-xr-x 1 ec2-user ec2-user  1637 May  9 23:59 ff13-2.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   587 May  9 23:59 ff13-3.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   134 May  9 23:59 ff1.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   537 May  9 23:59 ff2.sh*
      -rwxr-xr-x 1 ec2-user ec2-user  1377 May  9 23:59 ff3-2.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   823 May  9 23:59 ff3-3.sh*
      -rwxr-xr-x 1 ec2-user ec2-user  1513 May  9 23:59 ff4.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   193 May  9 23:59 ff6-1.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   294 May  9 23:59 ff6-2.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   242 May  9 23:59 ff6-3.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   134 May  9 23:59 ff7.sh*
      -rwxr-xr-x 1 ec2-user ec2-user   794 May  9 23:59 ff8-1.sh*
      -rwxr-xr-x 1 ec2-user ec2-user  1223 May  9 23:59 ff8-2.sh*
      -rwxrwxr-x 1 ec2-user ec2-user   886 May 10 00:01 hosts-env.sh*
      -rw-r--r-- 1 ec2-user ec2-user   799 May 10 00:01 lightning-csv.toml
      -rw-r--r-- 1 ec2-user ec2-user   721 May 10 00:01 lightning-p1.toml
      -rw-r--r-- 1 ec2-user ec2-user   731 May 10 00:01 lightning-p2.toml
      -rw-r--r-- 1 ec2-user ec2-user   397 May 10 00:01 six-nodes-dm-hybrid.yaml
      -rw-r--r-- 1 ec2-user ec2-user   207 May 10 00:01 solution-scale-out-tikv.yaml
      -rw-r--r-- 1 ec2-user ec2-user  4142 May 10 00:01 solution-tiup-meta.yaml
      -rwxrwxr-x 1 ec2-user ec2-user    18 May 10 00:01 ssh-to-cm.sh*
      -rwxrwxr-x 1 ec2-user ec2-user    19 May 10 00:01 ssh-to-db1.sh*
      -rwxrwxr-x 1 ec2-user ec2-user    19 May 10 00:01 ssh-to-db2.sh*
      -rwxrwxr-x 1 ec2-user ec2-user    19 May 10 00:01 ssh-to-kv1.sh*
      -rwxrwxr-x 1 ec2-user ec2-user    19 May 10 00:01 ssh-to-kv2.sh*
      -rwxrwxr-x 1 ec2-user ec2-user    19 May 10 00:01 ssh-to-kv3.sh*
      -rwxrwxr-x 1 ec2-user ec2-user    18 May 10 00:01 ssh-to-monitor1.sh*
      -rwxrwxr-x 1 ec2-user ec2-user    19 May 10 00:01 ssh-to-pd1.sh*
      -rwxrwxr-x 1 ec2-user ec2-user    19 May 10 00:01 ssh-to-pd2.sh*
      -rwxrwxr-x 1 ec2-user ec2-user    19 May 10 00:01 ssh-to-pd3.sh*
      -rwxrwxr-x 1 ec2-user ec2-user    19 May 10 00:01 ssh-to-tiflash1.sh*
      drwxr-xr-x 3 ec2-user ec2-user   168 May  9 23:59 stage/
      -rwxr-xr-x 1 ec2-user ec2-user    80 May  9 23:59 start-cluster.sh*
      -rwxr-xr-x 1 ec2-user ec2-user    58 May  9 23:59 stop-cluster.sh*
      -rw-r--r-- 1 ec2-user ec2-user  1940 May 10 00:01 sync-diff-config.toml
      -rw-r--r-- 1 ec2-user ec2-user   819 May  9 23:59 template-lightning-csv.toml
      -rw-r--r-- 1 ec2-user ec2-user   741 May  9 23:59 template-lightning-p1.toml
      -rw-r--r-- 1 ec2-user ec2-user   741 May  9 23:59 template-lightning-p2.toml
      -rw-r--r-- 1 ec2-user ec2-user   223 May  9 23:59 template-scale-out-tikv.yaml
      -rw-r--r-- 1 ec2-user ec2-user   487 May  9 23:59 template-six-nodes-dm-hybrid.yaml
      -rw-r--r-- 1 ec2-user ec2-user  1960 May  9 23:59 template-sync-diff-config.toml
      -rw-r--r-- 1 ec2-user ec2-user  1935 May  9 23:59 template-ten-nodes.yaml
      -rw-r--r-- 1 ec2-user ec2-user   240 May  9 23:59 template-three-nodes-scale-out-ticdc.yaml
      -rw-r--r-- 1 ec2-user ec2-user  4285 May  9 23:59 template-tiup-meta.yaml
      -rw-r--r-- 1 ec2-user ec2-user  1792 May 10 00:01 ten-nodes.yaml
      -rw-r--r-- 1 ec2-user ec2-user   210 May 10 00:01 three-nodes-scale-out-ticdc.yaml
      ```

3. This guide stops here, follow the instructions from your instructor and the lab guide to complete the execises. 
