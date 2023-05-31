# Notes
1. **DO NOT** deploy the demo Cloud Formation in production environment. You are at your own risk.
2. This demo requires **Python3**, **awscli**, and **boto3** installed on your local machine.
3. You need an active AWS account for testing purposes. And, your IAM user or role should have the permissions to create various AWS resources, it should be an admin IAM user/role or a power user/role. The identity you use must have the permissions to manage following services or resources: IAM roles, VPC, EC2, ELB, SQS, Lambda, IAM roles, CloudWatch, CloudWatch Logs, Auto Scaling Group, EventBridge, CloudFormation. 
4. **MAKE SURE** you also follow the instructions to tear down the demo environment after the showcase, otherwise AWS will keep charging you.
5. Estimated demo cost: ~1 USD.

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
    $ cd tidb-course-201-lab/tidb-quick-demo/005-online-upgrade-by-real-cluster/setup/
    ```
    ```
    $ ./deploy-quick-demo-stack-on-aws.sh <YOUR_NAME> <YOUR_EMAIL>
    ```
    ```
    $ ./deploy-quick-demo-stack-on-aws.sh gxxxxxxxi gxxxxxxxi@pXXXXXXXm
      {
          "StackId": "arn:aws:cloudformation:us-west-2:XXXXXXXXXX:stack/quick-demo-002/d9caf6b0-ed4f-11ed-ac4e-02ca195509c9"
      }
    ```

4. Wait the Cloud Formation stack run to completion. Run following script to check the status, until you get the `COMPLETION` status on `StackStatus` attribute in the output. It will create 1 VPC, 4 subnets, 5 auto scaling groups and 11 EC2 instances for you:
    ```
    $ ./show-quick-demo-stack-on-aws.sh
    ``` 
    ```
    $ ./show-quick-demo-stack-on-aws.sh 
      {
          "Stacks": [
              {
                  "StackId": "arn:aws:cloudformation:us-west-2:XXXXXXXXXX:stack/quick-demo-002/d9caf6b0-ed4f-11ed-ac4e-02ca195509c9",
                  "StackName": "quick-demo-005",
                  "Parameters": [
                      {
                          "ParameterKey": "TrainerEmail",
                          "ParameterValue": "gxxxxxxxi@pXXXXXXXm"
                      },
                      {
                          "ParameterKey": "TrainerName",
                          "ParameterValue": "gxxxxxxxi"
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

5. Add the private key identity to the SSH authentication agent:
    ```
    $ ssh-add ~/.ssh/pe-class-key.pem
    ```

6. Tag the demo EC2 instances by running `demo_start.sh <YOUR_NAME>`:
    ```
    $ ./demo_start.sh <YOUR_NAME>
    ```
    ```
    $ ./demo_start.sh gxxxxxxi

      ##################################################
      # Waiting for 150 seconds for nodes starting up. #
      ##################################################

      1 students with 1 monitor node(s).
      1 students with 3 pd node(s).
      1 students with 3 kv node(s).
      1 students with 2 db node(s).
      1 students with 2 tiproxy node(s).
      Tagging i-05e057b50753f1bf4 with class-user1:monitor1
      Tagging monitor nodes completed.
      Tagging i-08795e0a2fa5cb542 with class-user1:pd1
      Tagging i-009cd15e6520cd64f with class-user1:pd2
      Tagging i-030a6221138417aba with class-user1:pd3
      Tagging pd nodes completed.
      Tagging i-056c6f3fc861bb656 with class-user1:kv1
      Tagging i-0c4668ac797846a7c with class-user1:kv2
      Tagging i-09d256b2dd4ddc06e with class-user1:kv3
      Tagging kv nodes completed.
      Tagging i-0e213e8721b3fd53c with class-user1:db1
      Tagging i-09a07eb498f444b95 with class-user1:db2
      Tagging db nodes completed.
      Tagging i-0b31f8159dd6865c5 with class-user1:tiproxy1
      Tagging i-0ac1181710bea2944 with class-user1:tiproxy2
      Tagging tiproxy nodes completed.
      Warning: Permanently added '34.xx.xx.53' (ED25519) to the list of known hosts.
      Generating a 4096 bit RSA private key
      ............++
      .........................................++
      writing new private key to 'key.pem'
      -----
      Warning: Permanently added '10.xx.xx.216' (ECDSA) to the list of known hosts.
      Warning: Permanently added '10.xx.xx.216' (ECDSA) to the list of known hosts.
      Warning: Permanently added '10.xx.xx.163' (ECDSA) to the list of known hosts.
      Warning: Permanently added '10.xx.xx.163' (ECDSA) to the list of known hosts.
      Warning: Permanently added '10.xx.xx.5' (ECDSA) to the list of known hosts.
      Warning: Permanently added '10.xx.xx.15' (ECDSA) to the list of known hosts.

      9 nodes are prepared for user user1 and trainer gxxxxxxi.
      Warning: Permanently added '34.xx.xx.53' (ED25519) to the list of known hosts.
      export HOST_MONITOR1_PRIVATE_IP=10.xx.xx.236
      export HOST_MONITOR1_PUBLIC_IP=34.xx.xx.53
      export HOST_CM_PRIVATE_IP=10.xx.xx.236
      export HOST_CM_PUBLIC_IP=34.xx.xx.53
      export HOST_PD1_PRIVATE_IP=10.xx.xx.79
      export HOST_PD1_PUBLIC_IP=35.xx.xx.123
      export HOST_PD2_PRIVATE_IP=10.xx.xx.239
      export HOST_PD2_PUBLIC_IP=34.xx.xx.130
      export HOST_PD3_PRIVATE_IP=10.xx.xx.60
      export HOST_PD3_PUBLIC_IP=34.xx.xx.128
      export HOST_DB1_PRIVATE_IP=10.xx.xx.216
      export HOST_DB1_PUBLIC_IP=35.xx.xx.177
      export HOST_DB2_PRIVATE_IP=10.xx.xx.163
      export HOST_DB2_PUBLIC_IP=34.xx.xx.74
      export HOST_KV1_PRIVATE_IP=10.xx.xx.54
      export HOST_KV1_PUBLIC_IP=54.xx.xx.211
      export HOST_KV2_PRIVATE_IP=10.xx.xx.13
      export HOST_KV2_PUBLIC_IP=54.xx.xx.114
      export HOST_KV3_PRIVATE_IP=10.xx.xx.174
      export HOST_KV3_PUBLIC_IP=54.xx.xx.197
      export HOST_TIPROXY1_PRIVATE_IP=10.xx.xx.5
      export HOST_TIPROXY2_PRIVATE_IP=10.xx.xx.15
      Warning: Permanently added '35.xx.xx.123' (ED25519) to the list of known hosts.
      Warning: Permanently added '35.xx.xx.123' (ED25519) to the list of known hosts.
      /etc/my.conf prepared on pd1
      Warning: Permanently added '34.xx.xx.130' (ED25519) to the list of known hosts.
      Warning: Permanently added '34.xx.xx.130' (ED25519) to the list of known hosts.
      /etc/my.conf prepared on pd2
      TiProxy instances registered to NLB target group arn:aws:elasticloadbalancing:us-west-2:373771598235:targetgroup/demo-target-group/46536346caf8778d

      # Running Nodes for All Trainers.

      | Instance ID         | Public IP    | Private IP   | Name    | Instructor | Student | Role     | Up Time (mins) |
      | :------------------ | :----------- | :----------- | :------ | :--------- | :------ | :------- | :------------- |
      | i-0e213e8721b3fd53c | 35.xx.xx.177 | 10.xx.xx.216 | db      | gxxxxxxi   | user1   | db1      | 5              |
      | i-09a07eb498f444b95 | 34.xx.xx.74  | 10.xx.xx.163 | db      | gxxxxxxi   | user1   | db2      | 5              |
      | i-056c6f3fc861bb656 | 54.xx.xx.211 | 10.xx.xx.54  | kv      | gxxxxxxi   | user1   | kv1      | 5              |
      | i-0c4668ac797846a7c | 54.xx.xx.114 | 10.xx.xx.13  | kv      | gxxxxxxi   | user1   | kv2      | 5              |
      | i-09d256b2dd4ddc06e | 54.xx.xx.197 | 10.xx.xx.174 | kv      | gxxxxxxi   | user1   | kv3      | 5              |
      | i-05e057b50753f1bf4 | 34.xx.xx.53  | 10.xx.xx.236 | monitor | gxxxxxxi   | user1   | monitor1 | 5              |
      | i-08795e0a2fa5cb542 | 35.xx.xx.123 | 10.xx.xx.79  | pd      | gxxxxxxi   | user1   | pd1      | 5              |
      | i-009cd15e6520cd64f | 34.xx.xx.130 | 10.xx.xx.239 | pd      | gxxxxxxi   | user1   | pd2      | 5              |
      | i-030a6221138417aba | 34.xx.xx.128 | 10.xx.xx.60  | pd      | gxxxxxxi   | user1   | pd3      | 5              |
      | i-0b31f8159dd6865c5 | 52.xx.xx.53  | 10.xx.xx.5   | tiproxy | gxxxxxxi   | user1   | tiproxy1 | 5              |
      | i-0ac1181710bea2944 | 35.xx.xx.53  | 10.xx.xx.15  | tiproxy | gxxxxxxi   | user1   | tiproxy2 | 5              |

      # Class Total Cost: 0.21999999999999997 (USD)

      # Reporting End - 2023-05-14 11:49:09.636190 with 11 nodes.
    ```

7.  Get the public IP address of the monitor EC2 instance. Run `check_nodes.sh`:
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    ```
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    34.xx.xx.53
    ```

8. Initialize the demo TiDB Cluster.
    + a. Login monitor instance, if you are prompted, enter `yes`:
      ```
      $ ssh -A ec2-user@34.xx.xx.53
      ```

    + b. On monitor instance, run `create-cluster-v651.sh` to create the TiDB cluster named `tidb-demo`. It takes around 5 minutes to complete.
    ```
    $ ./create-cluster-v651.sh 
      ...
      Started cluster `tidb-demo` successfully
      tiup is checking updates for component cluster ...
      Starting component `cluster`: /home/ec2-user/.tiup/components/cluster/v1.12.1/tiup-cluster display tidb-demo
      Cluster type:       tidb
      Cluster name:       tidb-demo
      Cluster version:    v6.5.1
      Deploy user:        ec2-user
      SSH type:           builtin
      Dashboard URL:      http://10.xx.xx.214:2379/dashboard
      Grafana URL:        http://10.xx.xx.10:3000
      ID                 Role          Host         Ports        OS/Arch       Status  Data Dir                      Deploy Dir
      --                 ----          ----         -----        -------       ------  --------                      ----------
      10.xx.xx.236:9093   alertmanager  10.xx.xx.236  9093/9094    linux/x86_64  Up      /tidb-data/alertmanager-9093  /tidb-deploy/alertmanager-9093
      10.xx.xx.236:3000   grafana       10.xx.xx.236  3000         linux/x86_64  Up      -                             /tidb-deploy/grafana-3000
      10.xx.xx.60:2379    pd            10.xx.xx.60   2379/2380    linux/x86_64  Up      /tidb-data/pd-2379            /tidb-deploy/pd-2379
      10.xx.xx.239:2379   pd            10.xx.xx.239  2379/2380    linux/x86_64  Up|L    /tidb-data/pd-2379            /tidb-deploy/pd-2379
      10.xx.xx.79:2379    pd            10.xx.xx.79   2379/2380    linux/x86_64  Up|UI   /tidb-data/pd-2379            /tidb-deploy/pd-2379
      10.xx.xx.236:9090   prometheus    10.xx.xx.236  9090/12020   linux/x86_64  Up      /tidb-data/prometheus-9090    /tidb-deploy/prometheus-9090
      10.xx.xx.216:4000   tidb          10.xx.xx.216  4000/10080   linux/x86_64  Up      -                             /tidb-deploy/tidb-4000
      10.xx.xx.163:4000   tidb          10.xx.xx.163  4000/10080   linux/x86_64  Up      -                             /tidb-deploy/tidb-4000
      10.xx.xx.54:20160   tikv          10.xx.xx.54   20160/20180  linux/x86_64  Up      /tidb-data/tikv-20160         /tidb-deploy/tikv-20160
      10.xx.xx.13:20160   tikv          10.xx.xx.13   20160/20180  linux/x86_64  Up      /tidb-data/tikv-20160         /tidb-deploy/tikv-20160
      10.xx.xx.174:20160  tikv          10.xx.xx.174  20160/20180  linux/x86_64  Up      /tidb-data/tikv-20160         /tidb-deploy/tikv-20160
      Total nodes: 11
      ```

9. Start the TiProxy service for session management.
   ```
   $ cd scripts/
   $ ./sd-005-csp-demo-tiproxy-start.sh
   ```

# Demo Workflow
1. Get the public ip of the monitor instance.
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    ```
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    34.xx.xx.53
    ```

2. SSH (enabling forward) to the mornitor instance.
    + a. Add the private key identity to the SSH authentication agent:
      ```
      $ ssh-add ~/.ssh/pe-class-key.pem
      ``` 

    + b. SSH into the `monitor` instance with forwarding enabeld:
      ```
      $ ssh -A ec2-user@<monitor_public_ip>
      ```
      ```
      $ ssh -A ec2-user@34.xx.xx.53
      Last login: Mon May  8 03:27:29 2023

             __|  __|_  )
             _|  (     /   Amazon Linux 2 AMI
            ___|\___|___|

      https://aws.amazon.com/amazon-linux-2/
      [ec2-user@ip-10-90-4-10 ~]$
      ```

3. Make sure the Raft replicas setting is 3 and create the test table:
   ```
   $ cd scripts/
   $ ./sd-005-csp-demo-workload-prepare.sh
   ```

4. Start the dummy workload, and keep the terminal window open:
   ```
   $ ./sd-005-csp-demo-workload-start.sh
   ```

5. Open a new terminal window, login monitor instance, run workload checker, and keep the terminal window open:
   ```
   $ ssh-add ~/.ssh/pe-class-key.pem
   $ ssh -A ec2-user@34.xx.xx.53
   $ cd scripts/
   $ ./sd-005-csp-demo-workload-check.sh
   ``` 


6. Open a new terminal window, upgrade your TiDB cluster from v6.5.1 to v6.5.2:
   ```
   $ ssh-add ~/.ssh/pe-class-key.pem
   $ ssh -A ec2-user@34.xx.xx.53
   $ tiup cluster upgrade tidb-demo v6.5.2 --yes
   ```

7. Obverse that the sample application connection has never affected during the upgrade.

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

2. Verify that the Cloud Formation stack had been dropped successfully. Run `show-quick-demo-stack-on-aws.sh` until you get a `Stack with id quick-demo-005 does not exist` error message:
   ```
   $ ./show-quick-demo-stack-on-aws.sh
   An error occurred (ValidationError) when calling the DescribeStacks operation: Stack with id quick-demo-005 does not exist
   ```