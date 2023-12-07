# Course TiDB Administration Class Setup Guide for Students

## Exercises Nodes Information
You will receive a table from your instructor that describes the exercise environment before each hands-on exercise. Such as the following, assume that you are assigned as `user2`:
      
      | Instance ID         | Public IP    | Private IP  | Name    | Instructor | Student | Role     | Up Time (mins) |
      | :------------------ | :----------- | :---------- | :------ | :--------- | :------ | :------- | :------------- |
      | i-08151997dd939a6bd | 54.xx.xx.70  | 10.90.2.209 | db      | gXXXXXXXo  | user2   | db1      | 3              |
      | i-093c618d76e4e5b25 | 52.xx.xx.15  | 10.90.3.6   | db      | gXXXXXXXo  | user2   | db2      | 3              |
      | i-095a704ff26b8e4cf | 34.xx.xx.47  | 10.90.3.86  | kv      | gXXXXXXXo  | user2   | kv1      | 2              |
      | i-015057ecff55e09b5 | 34.xx.xx.38  | 10.90.1.84  | kv      | gXXXXXXXo  | user2   | kv2      | 2              |
      | i-056f185f8bfdfd293 | 35.xx.xx.198 | 10.90.2.253 | kv      | gXXXXXXXo  | user2   | kv3      | 2              |
      | i-0bb0553841ecc0451 | 35.xx.xx.55  | 10.90.4.220 | monitor | gXXXXXXXo  | user2   | monitor1 | 3              |
      | i-0823a3a917d5bf87f | 35.xx.xx.193 | 10.90.1.124 | pd      | gXXXXXXXo  | user2   | pd1      | 3              |
      | i-0bd3492919928e185 | 35.xx.xx.248 | 10.90.2.124 | pd      | gXXXXXXXo  | user2   | pd2      | 3              |
      | i-01847bab040690d96 | 34.xx.xx.209 | 10.90.3.168 | pd      | gXXXXXXXo  | user2   | pd3      | 3              |
      | i-04d8f0c4345244f51 | 34.xx.xx.183 | 10.90.4.74  | tiflash | gXXXXXXXo  | user2   | tiflash1 | 3              |

## Assumptions
1. Please ensure that your laptop and internet connection have access to port 22 on the internet host.

## Laptop Setup and SSH Login (Linux or macOS)
1. You will receive a private key file, `*.pem`, from your instructor, make sure the permission is set to `400`.
      ```
      $ mv <key_file> ~/.ssh/ 
      $ chmod 400 ~/.ssh/<key_file>
      ``` 

2. Connect to your EC2 instance, using the following commands with `SSH` forward enabled. The example is using the `monitor1` node as the login target:
    
    Add the private key identity to the OpenSSH authentication agent.
    ```
    $ ssh-add  ~/.ssh/<key_file>
    ```
    
    The option `-A` for command `SSH` is crucial as it enables the forwarding of connections from an authentication agent. It is necessary to support passwordless hands-on steps throughout the exercise workflows.
    ```
    $ ssh -A ec2-user@34.220.83.xx
    ```

## Laptop Setup and SSH Login (Windows)
1. Install [PuTTY](https://www.putty.org/) on your computer.
   
   Download and install PuTTY from the [PuTTY](https://www.putty.org/) official page. If you already have an older version of PuTTY installed, we recommend that you download the latest version. Be sure to install the entire suite.

2. Convert the private key file (`*.pem`), from your instructor, to `*.ppk` format using [PuTTYgen](https://www.puttygen.com/). 

   You may follow the [guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html) by AWS in the section `Convert your private key using PuTTYgen`.

3. Configure the key-quartermaster.
   + Open `Pageant` from the start menu. (Note: it may run off to the system tray)
   + Click `Add Key` to include the key in `*.ppk` format.

4. Connect to EC2 Instance from Windows using PuTTy.

   Make sure that you also allow the agent SSH forwarding in PuTTY (See the image below. It might be slightly different from yours due to software versions).

   <img src="./ninja-kits/diagram/PuttyAllowAgentForwarding_aa_001_20230109.png" width="50%" align="top"/>

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

3. This guide stops here, follow the instructions from your instructor and the lab guide to complete the execises. 
