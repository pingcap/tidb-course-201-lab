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
    $ cd setup/
    $ ./deploy-quick-demo-stack-on-aws.sh <YOUR_NAME> <YOUR_EMAIL>
    ```
    ```
    $ ./deploy-quick-demo-stack-on-aws.sh gXXXXXXXo gXXXXXXXo@pXXXXXXXm
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

5. Add the private key identity to the SSH authentication agent:
    ```
    $ ssh-add ~/.ssh/pe-class-key.pem
    ```

6. Tag the demo EC2 instances by running `demo_start.sh <YOUR_NAME>`:
    ```
    $ ./demo_start.sh <YOUR_NAME>
    ```
    ```
    $ ./demo_start.sh guanglei

##################################################
# Waiting for 150 seconds for nodes starting up. #
##################################################

1 students with 0 monitor node(s).
ERROR: Total available monitor nodes count is 0 instead of 1.
SOLUTION: Please wait and retry later or contact PE team.
ssh: Could not resolve hostname none: nodename nor servname provided, or not known
ssh: Could not resolve hostname none: nodename nor servname provided, or not known
ssh: Could not resolve hostname none: nodename nor servname provided, or not known
ssh: Could not resolve hostname none: nodename nor servname provided, or not known
/etc/my.conf prepared on pd1
ssh: Could not resolve hostname none: nodename nor servname provided, or not known
ssh: Could not resolve hostname none: nodename nor servname provided, or not known
/etc/my.conf prepared on pd2

An error occurred (ValidationError) when calling the RegisterTargets operation: The IP address 'None' is not a valid IPv4 address
TiProxy instances registered to NLB target group arn:aws:elasticloadbalancing:us-west-2:373771598235:targetgroup/demo-target-group/dfbfcbb628bd0d20

* Note: Setup in progress for i-0f55ead8f5fb0beee.
* Note: i-0f55ead8f5fb0beee might need to be adding two tags with keys: `role` and `student` manually.

* Note: Setup in progress for i-0e53e0a0a6b1953b7.
* Note: i-0e53e0a0a6b1953b7 might need to be adding two tags with keys: `role` and `student` manually.

* Note: Setup in progress for i-06c293c21b2b7d66b.
* Note: i-06c293c21b2b7d66b might need to be adding two tags with keys: `role` and `student` manually.

* Note: Setup in progress for i-0796c63dbec1529c4.
* Note: i-0796c63dbec1529c4 might need to be adding two tags with keys: `role` and `student` manually.

* Note: Setup in progress for i-0bb9eb7bdf1caef74.
* Note: i-0bb9eb7bdf1caef74 might need to be adding two tags with keys: `role` and `student` manually.

* Note: Setup in progress for i-0f30a85e7240205c6.
* Note: i-0f30a85e7240205c6 might need to be adding two tags with keys: `role` and `student` manually.

* Note: Setup in progress for i-0577f402d23e2747f.
* Note: i-0577f402d23e2747f might need to be adding two tags with keys: `role` and `student` manually.

* Note: Setup in progress for i-07a5ec4125e4db59a.
* Note: i-07a5ec4125e4db59a might need to be adding two tags with keys: `role` and `student` manually.

* Note: Setup in progress for i-0621e143a2a0c40ce.
* Note: i-0621e143a2a0c40ce might need to be adding two tags with keys: `role` and `student` manually.

* Note: Setup in progress for i-0dcdacb1cb4e81f03.
* Note: i-0dcdacb1cb4e81f03 might need to be adding two tags with keys: `role` and `student` manually.

* Note: Setup in progress for i-0ee2c3f33a5d9aad0.
* Note: i-0ee2c3f33a5d9aad0 might need to be adding two tags with keys: `role` and `student` manually.

# Running Nodes for All Trainers.


| Instance ID         | Public IP        | Private IP       | Name          | Instructor | Student | Role      | Up Time (mins) |
| :------------------ | :--------------- | :----------------| :------------ | :--------- | :------ | :-------- |:-------------- |
| i-0577f402d23e2747f | 35.86.155.15     | 10.90.1.134      | kv            | guanglei.bao@pingcap.com |   |   | 6              | 
| i-0621e143a2a0c40ce | 35.87.26.192     | 10.90.2.198      | db            | guanglei.bao@pingcap.com |   |   | 6              | 
| i-06c293c21b2b7d66b | 52.40.78.96      | 10.90.2.81       | kv            | guanglei.bao@pingcap.com |   |   | 6              | 
| i-0796c63dbec1529c4 | 54.200.140.226   | 10.90.2.166      | tiproxy       | guanglei.bao@pingcap.com |   |   | 6              | 
| i-07a5ec4125e4db59a | 35.89.110.231    | 10.90.1.184      | pd            | guanglei.bao@pingcap.com |   |   | 6              | 
| i-0bb9eb7bdf1caef74 | 34.213.44.75     | 10.90.2.51       | pd            | guanglei.bao@pingcap.com |   |   | 6              | 
| i-0dcdacb1cb4e81f03 | 54.149.26.186    | 10.90.3.174      | tiproxy       | guanglei.bao@pingcap.com |   |   | 6              | 
| i-0e53e0a0a6b1953b7 | 34.220.193.161   | 10.90.3.54       | pd            | guanglei.bao@pingcap.com |   |   | 6              | 
| i-0ee2c3f33a5d9aad0 | 54.186.24.236    | 10.90.3.150      | kv            | guanglei.bao@pingcap.com |   |   | 6              | 
| i-0f30a85e7240205c6 | 54.200.160.90    | 10.90.1.82       | db            | guanglei.bao@pingcap.com |   |   | 6              | 
| i-0f55ead8f5fb0beee | 18.246.0.200     | 10.90.4.8        | monitor       | guanglei.bao@pingcap.com |   |   | 6              | 

# Class Total Cost: 0.21999999999999997 (USD)

# Reporting End - 2023-05-14 11:13:44.669796 with 11 nodes.
    ```

7.  Get the public IP address of the monitor EC2 instance. Run `check_nodes.sh`:
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    ```
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    18.x.x.163
    ```

8. Initialize the demo TiDB Cluster.
    + a. Login monitor instance, if you are prompted, enter `yes`:
      ```
      $ ssh -A ec2-user@18.x.x.163
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
      Dashboard URL:      http://10.90.3.214:2379/dashboard
      Grafana URL:        http://10.90.4.10:3000
      ID                 Role          Host         Ports        OS/Arch       Status  Data Dir                      Deploy Dir
      --                 ----          ----         -----        -------       ------  --------                      ----------
      10.90.4.10:9093    alertmanager  10.90.4.10   9093/9094    linux/x86_64  Up      /tidb-data/alertmanager-9093  /tidb-deploy/alertmanager-9093
      10.90.4.10:3000    grafana       10.90.4.10   3000         linux/x86_64  Up      -                             /tidb-deploy/grafana-3000
      10.90.1.246:2379   pd            10.90.1.246  2379/2380    linux/x86_64  Up|L    /tidb-data/pd-2379            /tidb-deploy/pd-2379
      10.90.2.161:2379   pd            10.90.2.161  2379/2380    linux/x86_64  Up      /tidb-data/pd-2379            /tidb-deploy/pd-2379
      10.90.3.214:2379   pd            10.90.3.214  2379/2380    linux/x86_64  Up|UI   /tidb-data/pd-2379            /tidb-deploy/pd-2379
      10.90.4.10:9090    prometheus    10.90.4.10   9090/12020   linux/x86_64  Up      /tidb-data/prometheus-9090    /tidb-deploy/prometheus-9090
      10.90.1.65:4000    tidb          10.90.1.65   4000/10080   linux/x86_64  Up      -                             /tidb-deploy/tidb-4000
      10.90.2.51:4000    tidb          10.90.2.51   4000/10080   linux/x86_64  Up      -                             /tidb-deploy/tidb-4000
      10.90.1.135:20160  tikv          10.90.1.135  20160/20180  linux/x86_64  Up      /tidb-data/tikv-20160         /tidb-deploy/tikv-20160
      10.90.2.194:20160  tikv          10.90.2.194  20160/20180  linux/x86_64  Up      /tidb-data/tikv-20160         /tidb-deploy/tikv-20160
      10.90.3.220:20160  tikv          10.90.3.220  20160/20180  linux/x86_64  Up      /tidb-data/tikv-20160         /tidb-deploy/tikv-20160
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
    18.x.x.163
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
      $ ssh -A ec2-user@18.x.x.163
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
   $ ssh -A ec2-user@18.x.x.163
   $ cd scripts/
   $ ./sd-002-csp-demo-workload-check.sh
   ``` 


6. Upgrade your TiDB cluster from v6.5.1 to v6.5.2:
   ```
   $ ssh-add ~/.ssh/pe-class-key.pem
   $ ssh -A ec2-user@18.x.x.163
   $ cd scripts/
   $ ./sd-002-csp-demo-hog-db.sh
   ``` 

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