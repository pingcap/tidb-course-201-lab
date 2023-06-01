# Notes
1. **You can perform this demo on TiUP Playground using your local node, without the need to use an actual TiDB cluster to demonstrate.**
2. **DO NOT** deploy the demo Cloud Formation in production environment. You are at your own risk.
3. This demo requires **Python3**, **awscli**, and **boto3** installed on your local machine.
4. You need an active AWS account for testing purposes. And, your IAM user or role should have the permissions to create various AWS resources, it should be an admin IAM user/role or a power user/role. The identity you use must have the permissions to manage following services or resources: IAM roles, VPC, EC2, ELB, SQS, Lambda, IAM roles, CloudWatch, CloudWatch Logs, Auto Scaling Group, EventBridge, CloudFormation. 
5. **MAKE SURE** you also follow the instructions to tear down the demo environment after the showcase, otherwise AWS will keep charging you.
6. Estimated demo cost: ~1 USD.

# Demo Preparation
1. Setup EC2 instance SSH identity:

    + a. On EC2 console, go to region "us-west-2" (Oregon). Under `Key Pairs` section, create a new key pair with name `pe-class-key`, and save the private key file (for example: `pe-class-key.pem`) to local directory `~/.ssh/`.

    + b. Change the private key file permission to `r--`:
      ```
      $ chmod 400 ~/.ssh/pe-class-key.pem
      ```

2. Setup AWS credentials for your terminal.
   
    + a. If you use permenant IAM power user, follow the [instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html) to set up the **default** awscli profile.
    
    + b. If you use temporary IAM power user or IAM role, set your credentials to following environment variables in your local terminal:
      ```
      $ export AWS_ACCESS_KEY_ID="<YOUR_AWS_ACCESS_KEY_ID>"
      $ export AWS_SECRET_ACCESS_KEY="<YOUR_AWS_SECRECT_ACCESS_KEY>"
      $ export AWS_SESSION_TOKEN="<YOUR_SESSION_TOKEN>"
      ```

3. Create the demo Cloud Formation stack. Provide your name and your email as input parameters (for resource tagging purpose, otherwise the demo steps will fail). This stack will be created in "us-west-2" (Oregon) region:
    ```
    $ git clone https://github.com/pingcap/tidb-course-201-lab.git
    $ cd tidb-course-201-lab/tidb-quick-demo/004-fast-adding-columns-online/setup/
    ```
    ```
    $ ./deploy-quick-demo-stack-on-aws.sh <YOUR_NAME> <YOUR_EMAIL>
    ```
    ```
    $ ./deploy-quick-demo-stack-on-aws.sh gXXXXXXXo gXXXXXXXo@pXXXXXXXm
      {
          "StackId": "arn:aws:cloudformation:us-west-2:XXXXXXXXXX:stack/quick-demo-002/d9caf6b0-ed4f-11ed-ac4e-02ca195509c9"
      }
    ```

4. Wait the Cloud Formation stack run to completion. Run following script to check the status, until you get the `COMPLETION` status on `StackStatus` attribute in the output. It will create 1 VPC, 4 subnets, 4 auto scaling groups, 9 EC2 instances, 1 Lambda function, 1 SQS queue for you:
    ```
    $ ./show-quick-demo-stack-on-aws.sh
    ``` 
    ```
    $ ./show-quick-demo-stack-on-aws.sh 
      {
          "Stacks": [
              {
                  "StackId": "arn:aws:cloudformation:us-west-2:XXXXXXXXXX:stack/quick-demo-002/d9caf6b0-ed4f-11ed-ac4e-02ca195509c9",
                  "StackName": "quick-demo-002",
                  "Parameters": [
                      {
                          "ParameterKey": "TrainerEmail",
                          "ParameterValue": "gXXXXXXXo@pXXXXXXXm"
                      },
                      {
                          "ParameterKey": "TrainerName",
                          "ParameterValue": "gXXXXXXXo"
                      }
                  ],
                  "CreationTime": "2023-05-08T03:24:33.184Z",
                  "RollbackConfiguration": {},
                  "StackStatus": "CREATE_COMPLETE",
                  "DisableRollback": false,
                  "NotificationARNs": [],
                  "Capabilities": [
                      "CAPABILITY_IAM"
                  ],
                  "Tags": [],
                  "EnableTerminationProtection": false,
                  "DriftInformation": {
                      "StackDriftStatus": "NOT_CHECKED"
                  }
              }
          ]
      }
    ```

5. Tag the demo EC2 instances by running `demo_start.sh <YOUR_NAME>`:
    ```
    $ ./demo_start.sh <YOUR_NAME>
    ```
    ```
      $ ./demo_start.sh gXXXXXXXo
      ##################################################
      # Waiting for 150 seconds for nodes starting up. #
      ##################################################
      ...
      # Reporting End - 2023-05-08 11:44:24.198537 with 10 nodes.
    ```

6. Add the private key identity to the SSH authentication agent:
    ```
    $ ssh-add ~/.ssh/pe-class-key.pem
    ```

7. Provision the demo cluster topology by running `demo_prewarm.sh <YOUR_NAME>`:
    ```
    $ ./demo_prewarm.sh <YOUR_NAME>
    ```
    ```
    $ ./demo_prewarm.sh gXXXXXXXo
    Warning: Permanently added '18.x.x.163' (ED25519) to the list of known hosts.

    9 nodes are prepared for user user1 and trainer gXXXXXXXo.
    ...
    # Reporting End - 2023-05-08 11:47:38.302259 with 10 nodes.
    ```

8. Get the public IP address of the monitor EC2 instance. Run `check_nodes.sh`:
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    ```
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    18.x.x.163
    ```

9. Initialize the demo TiDB Cluster.
    + a. Login monitor instance, if you are prompted, enter `yes`:
      ```
      $ ssh -A ec2-user@18.x.x.163
      ```

    + b. On monitor instance, run `create-cluster-v651.sh` to create the TiDB cluster named `tidb-demo`. It takes around 5 minutes to complete.
      ```
      $ ./create-cluster-v651.sh 
      ...
      Total nodes: 12
      ```

# Demo Workflow
1. Get the public ip of the monitor instance.
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    ```
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    18.x.x.163
    ```

2. Open **4 terminals**, and SSH (enabling forward) to the mornitor instance.
    a. Add the private key identity to the SSH authentication agent:
      ```
      $ ssh-add ~/.ssh/pe-class-key.pem
      ``` 

    b. SSH into the `monitor` instance with forwarding enabeld:
      ```
      $ ssh -A ec2-user@<monitor_public_ip>
      ```
      ```
      $ ssh -A ec2-user@18.x.x.163
      Last login: Mon May  8 03:27:29 2023

             __|  __|_  )
             _|  (     /   Amazon Linux 2 AMI
            ___|\___|___|

      https://aws.amazon.com/amazon-linux-2/
      [ec2-user@ip-10-90-4-254 ~]$
      ```

## Demo 1: TiDB with Metadata Lock disabled when dealing with long transactions.
3. On all **4 terminals**, connect to TiDB.
   ```
   $ ./connect-db1.sh
   ```
   ```
   $ ./connect-db1.sh
   Welcome to the MySQL monitor.  Commands end with ; or \g.
   ...
   tidb:db1> 
   ```

4. In terminal 1, check the value of the system variable `tidb_enable_metadata_lock`. If the value is `ON`, update the value to `OFF`.
    ```
    tidb:db1> SHOW VARIABLES LIKE "tidb_enable_metadata_lock"; 
    tidb:db1> SET GLOBAL tidb_enable_metadata_lock = OFF;
    ```
    ```
    tidb:db1> SHOW VARIABLES LIKE "tidb_enable_metadata_lock"; 
    +---------------------------+-------+
    | Variable_name             | Value |
    +---------------------------+-------+
    | tidb_enable_metadata_lock | ON    |
    +---------------------------+-------+
    1 row in set (0.00 sec)

    tidb:db1> SET GLOBAL tidb_enable_metadata_lock = OFF;
    uery OK, 0 rows affected (0.02 sec)
    ```

5. In terminal 1, create the database `demo`, table `t1`, insert some values into the table, and start a transaction.
    ```
    tidb:db1> DROP DATABASE IF EXISTS demo;
    tidb:db1> CREATE DATABASE demo;
    tidb:db1> USE demo;
    tidb:db1> CREATE TABLE IF NOT EXISTS t1 (
                id BIGINT NOT NULL PRIMARY KEY auto_increment,
                num INT
                );
    tidb:db1> INSERT INTO t1(num) VALUES (1);
    tidb:db1> INSERT INTO t1(num) VALUES (2);
    tidb:db1> BEGIN;
    tidb:db1> INSERT INTO t1(num) VALUES (3);
    ```
    ```
    tidb:db1> DROP DATABASE IF EXISTS demo;
    Query OK, 0 rows affected (0.52 sec)

    tidb:db1> CREATE DATABASE demo;
    Query OK, 0 rows affected (0.53 sec)

    tidb:db1> USE demo;
    Database changed

    tidb:db1> CREATE TABLE IF NOT EXISTS t1 (
    ->  id BIGINT NOT NULL PRIMARY KEY auto_increment,
    ->  num INT
    -> );
    Query OK, 0 rows affected (0.53 sec)

    tidb:db1> INSERT INTO t1(num) VALUES (1);
    Query OK, 1 row affected (0.01 sec)

    tidb:db1> INSERT INTO t1(num) VALUES (2);
    Query OK, 1 row affected (0.00 sec)

    tidb:db1> BEGIN;
    Query OK, 0 rows affected (0.00 sec)

    tidb:db1> INSERT INTO t1(num) VALUES (3);
    Query OK, 1 row affected (0.00 sec)
    ```

6. In terminal 2, add a column to the table `t1`.
    ```
    tidb:db1> USE demo;
    tidb:db1> ALTER TABLE t1 ADD COLUMN c1 INT;
    ```
    ```
    tidb:db1> USE demo;
    Reading table information for completion of table and column names
    You can turn off this feature to get a quicker startup with -A

    Database changed
    tidb:db1> ALTER TABLE t1 ADD COLUMN c1 INT;
    Query OK, 0 rows affected (9.03 sec)
    ```

7. In terminal 3, insert a record into the table.
    ```
    tidb:db1> USE demo;
    tidb:db1> INSERT INTO t1(num) VALUES (4); 
    ```
    ```
    tidb:db1> USE demo;
    Reading table information for completion of table and column names
    You can turn off this feature to get a quicker startup with -A

    Database changed
    tidb:db1> INSERT INTO t1(num) VALUES (4); 
    Query OK, 1 row affected (0.00 sec)
    ```

8. In terminal 4, query the table.
    ```
    tidb:db1> USE demo;
    tidb:db1> SELECT * FROM t1; 
    ```
    ```
    tidb:db1> USE demo;
    Reading table information for completion of table and column names
    You can turn off this feature to get a quicker startup with -A

    Database changed
    tidb:db1> SELECT * FROM t1; 
    +----+------+------+
    | id | num  | c1   |
    +----+------+------+
    |  1 |    1 | NULL |
    |  2 |    2 | NULL |
    |  4 |    4 | NULL |
    +----+------+------+
    3 rows in set (0.00 sec)
    ```

9. Commit the transaction in terminal 1.
    ```
    tidb:db1> COMMIT;
    ERROR 8028 (HY000): Information schema is changed during the execution of the statement(for example, table definition may be updated by other DDL ran in parallel). If you see this error often, try increasing `tidb_max_delta_schema_count`. [try again later]
    ```

## Demo 2: TiDB with Metadata Lock Disabled when dealing with short transactions.
10. In terminal 1, change directory, and start the Java program to keep inserting some values into the `t1` table.
    ```
    $ cd scripts/
    $ ./sd-003-csp-demo-workload-tidb-8028.sh
    ```
    ```
    $ cd scripts/
    $ ./sd-003-csp-demo-workload-tidb-8028.sh
    Connecton established.
    0 rows inserted.
    1 rows inserted.
    2 rows inserted.
    ...
    ```

11. In terminal 2, terminal 3, and terminal 4, repeat step 6, 7, and 8. Observe the difference.

## Demo 3: TiDB with Metadata Lock enabled.
12. In terminal 1, change the value of the system variable `tidb_enable_metadata_lock` to `ON`.
    ```
    tidb:db1> SET GLOBAL tidb_enable_metadata_lock = ON;
    tidb:db1> SHOW VARIABLES LIKE "tidb_enable_metadata_lock"; 
    ```
    ```
    tidb:db1> SET GLOBAL tidb_enable_metadata_lock = ON;
    uery OK, 0 rows affected (0.02 sec)

    tidb:db1> SHOW VARIABLES LIKE "tidb_enable_metadata_lock"; 
    +---------------------------+-------+
    | Variable_name             | Value |
    +---------------------------+-------+
    | tidb_enable_metadata_lock | ON    |
    +---------------------------+-------+
    1 row in set (0.00 sec)
    ```

13. Repeat the step 6, 7 and 8. Observe the difference. Then, exit the connection with TiDB.

## Demo 4: MySQL

14. In all four terminals, connect to PD1.
    ```
    $ ./ssh-to-pd1.sh 
    ```
    ```
    $ ./ssh-to-pd1.sh 
    Last login: Thu May 11 00:51:19 2023 from ip-10-90-4-254.us-west-2.compute.internal

        __|  __|_  )
        _|  (     /   Amazon Linux 2 AMI
        ___|\___|___|

    https://aws.amazon.com/amazon-linux-2/
    ```
15. In terminal 1, start MySQL server instance:
    ```
    $ sudo service mysqld start
    ```
    ```
    $ sudo service mysqld start
    Redirecting to /bin/systemctl start mysqld.service
    ```

16. Get the temporary password for `root@'localhost'`, then **jot down it** for subsequent steps. 
   ```
   $ ./show-mysql-password.sh
   ```
   ```
   $ ./show-mysql-password.sh
   SyJujk,V8amm
   ```

17. Log in MySQL server on port 3306 as `root@'localhost'` and change the default password to `q1w2e3R4_'`. 
   ```
   $ mysql -u root -p -h 127.0.0.1 -P 3306
   ```
   ```sql
   mysql> ALTER USER root@'localhost' IDENTIFIED BY 'q1w2e3R4_';
   ```
   ```
   mysql> ALTER USER root@'localhost' IDENTIFIED BY 'q1w2e3R4_';
   Query OK, 0 rows affected (0.00 sec)
   ```

18. Repeat step 5, 6, 7, and 8 in terminal 1 to 4, observe the results. Note that you need to login to MySQL on terminal 2, 3, and 4.

# Tear Down the Demo Environment
1. On your local machine, under `setup` directory, run `remove-quick-demo-stack-on-aws.sh` and `show-quick-demo-stack-on-aws.sh`:
   ```
   $ cd setup/
   $ ./remove-quick-demo-stack-on-aws.sh 
   $ ./show-quick-demo-stack-on-aws.sh 
   {
       "Stacks": [
           {
               ...
               "StackStatus": "DELETE_IN_PROGRESS",
               ...
           }
       ]
   }
   ```

2. Verify that the Cloud Formation stack had been dropped successfully. Run `show-quick-demo-stack-on-aws.sh` until you get a `Stack with id quick-demo-003 does not exist` error message:
   ```
   $ ./show-quick-demo-stack-on-aws.sh
   An error occurred (ValidationError) when calling the DescribeStacks operation: Stack with id quick-demo-003 does not exist
   ```