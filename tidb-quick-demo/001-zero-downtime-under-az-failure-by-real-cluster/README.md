# Notes
1. **DO NOT** deploy the demo Cloud Formation in production environment. You are at your own risk.
2. This demo requires **Python3**, **awscli**, and **boto3** installed on your local machine.
3. You need an active AWS account for testing purposes. And, your IAM user or role should have the permissions to create various AWS resources, it should be an admin IAM user/role or a power user/role. The identity you use must have the permissions to manage following services or resources: IAM roles, VPC, EC2, IAM roles, CloudWatch, Auto Scaling Group, CloudFormation. 
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
          "StackId": "arn:aws:cloudformation:us-west-2:XXXXXXXXXX:stack/quick-demo-001/d9caf6b0-ed4f-11ed-ac4e-02ca195509c9"
      }
    ```

4. Wait the Cloud Formation stack run to completion. Run following script to check the status, until you get the `COMPLETION` status on `StackStatus` attribute in the output. It will create 1 VPC, 4 subnets, 4 auto scaling groups, 9 EC2 instances:
    ```
    $ ./show-quick-demo-stack-on-aws.sh
    ``` 
    ```
    $ ./show-quick-demo-stack-on-aws.sh 
      {
          "Stacks": [
              {
                  "StackId": "arn:aws:cloudformation:us-west-2:XXXXXXXXXX:stack/quick-demo-001/d9caf6b0-ed4f-11ed-ac4e-02ca195509c9",
                  "StackName": "quick-demo-001",
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

      1 students with 1 monitor node(s).
      1 students with 3 pd node(s).
      1 students with 3 kv node(s).
      1 students with 2 db node(s).
      Tagging i-077aa2ac6f2bab7f1 with class-user1:monitor1
      Tagging monitor nodes completed.
      Tagging i-05e090962cc957cda with class-user1:pd1
      Tagging i-05963bfd4677316e1 with class-user1:pd2
      Tagging i-05a582c969c495da8 with class-user1:pd3
      Tagging pd nodes completed.
      Tagging i-0480c068ff1b74034 with class-user1:kv1
      Tagging i-08fa9f33b23cb53e4 with class-user1:kv2
      Tagging i-008d13b205c2a912c with class-user1:kv3
      Tagging kv nodes completed.
      Tagging i-02ecfdf8acd97d9ba with class-user1:db1
      Tagging i-07ea24f4f69c8e666 with class-user1:db2
      Tagging db nodes completed.

      # Running Nodes for All Trainers.


      | Instance ID         | Public IP  | Private IP  | Name    | Instructor | Student | Role     | Up Time (mins) |
      | :------------------ | :--------- | :---------- | :------ | :--------- | :------ | :------- | :------------- |
      | i-02ecfdf8acd97d9ba | 54.x.x.231 | 10.90.1.65  | db      | gXXXXXXXo  | user1   | db1      | 19             |
      | i-07ea24f4f69c8e666 | 35.x.x.18  | 10.90.2.51  | db      | gXXXXXXXo  | user1   | db2      | 19             |
      | i-0480c068ff1b74034 | 35.x.x.112 | 10.90.1.135 | kv      | gXXXXXXXo  | user1   | kv1      | 19             |
      | i-08fa9f33b23cb53e4 | 54.x.x.139 | 10.90.3.220 | kv      | gXXXXXXXo  | user1   | kv2      | 19             |
      | i-008d13b205c2a912c | 34.x.x.233 | 10.90.2.194 | kv      | gXXXXXXXo  | user1   | kv3      | 19             |
      | i-077aa2ac6f2bab7f1 | 18.x.x.163 | 10.90.4.10  | monitor | gXXXXXXXo  | user1   | monitor1 | 19             |
      | i-05e090962cc957cda | 34.x.x.160 | 10.90.1.246 | pd      | gXXXXXXXo  | user1   | pd1      | 19             |
      | i-05963bfd4677316e1 | 35.x.x.205 | 10.90.2.161 | pd      | gXXXXXXXo  | user1   | pd2      | 19             |
      | i-05a582c969c495da8 | 35.x.x.56  | 10.90.3.214 | pd      | gXXXXXXXo  | user1   | pd3      | 19             |

      # Class Total Cost: 0.54 (USD)

      # Reporting End - 2023-05-08 11:44:24.198537 with 9 nodes.
    ```

8. Add the private key identity to the SSH authentication agent:
    ```
    $ ssh-add ~/.ssh/pe-class-key.pem
    ```

9.  Provision the demo cluster topology by running `demo_prewarm.sh <YOUR_NAME>`:
    ```
    $ ./demo_prewarm.sh <YOUR_NAME>
    ```
    ```
    $ ./demo_prewarm.sh gXXXXXXXo
    Warning: Permanently added '18.x.x.163' (ED25519) to the list of known hosts.

    9 nodes are prepared for user user1 and trainer gXXXXXXXo.
    ...
    # Reporting End - 2023-05-08 11:47:38.302259 with 9 nodes.
    ```

10. Get the public IP address of the monitor EC2 instance. Run `check_nodes.sh`:
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    ```
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    18.x.x.163
    ```

11. Initialize the demo TiDB Cluster.
    a. Login monitor instance, if you are prompted, enter `yes`:
    ```
    $ ssh -A ec2-user@18.x.x.163
    ```

    b. On monitor instance, run `create-cluster-v651.sh` to create the TiDB cluster named `tidb-demo`. It takes around 5 minutes to complete.
    ```
    $ ./create-cluster-v651.sh 
    ...
    Started cluster `tidb-demo` successfully
    tiup is checking updates for component cluster ...
    Starting component `cluster`: /home/ec2-user/.tiup/components/cluster/v1.12.1/tiup-cluster display tidb-demo
    Cluster type:       tidb
    Cluster name:       tidb-demo
    Cluster version:    v6.5.1
    Deploy user:        tidb
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

# Demo Workflow
1. Get the public ip of the monitor instance.
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    ```
    ```
    $ ./check_nodes.sh | grep monitor | awk -F"|" '{print $3}'
    18.x.x.163
    ```

2. SSH to the mornitor instance.
    a. Add the private key identity to the SSH authentication agent:
      ```
      $ ssh-add ~/.ssh/pe-class-key.pem
      ``` 

    b. SSH into the `monitor1` instance with forwarding enabeld:
      ```
      $ ssh ec2-user@<monitor_public_ip>
      ```
      ```
      $ ssh ec2-user@18.x.x.163
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
   $ ./sd-001-csp-demo-workload-prepare.sh
   ```

4. Start the dummy workload, and keep the terminal window open:
   ```
   $ ./sd-001-csp-demo-workload-start.sh
   ```

5. Open a new terminal window, login `monitor1` instance, run workload checker, and keep the terminal window open:
   ```
   $ ssh-add ~/.ssh/pe-class-key.pem
   $ ssh ec2-user@18.x.x.163
   $ cd scripts/
   $ ./sd-001-csp-demo-workload-check.sh
   ``` 

6. Pick up a subnet with `PD`, `TiKV` and `TiDB`instances in it, and isolate it by execute `sd-001-csp-demo-subnet-close.sh demo-subnet-1|demo-subnet-2|demo-subnet-3|demo-subnet-4`. For example the subnet `demo-subnet-1`:
   ```
   $ cd tidb-course-201-lab/scripts/
   $ ./sd-001-csp-demo-subnet-close.sh demo-subnet-1
   {
    "NewAssociationId": "aclassoc-0bf20fbe08121ddec"
   }
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

2. Verify that the Cloud Formation stack had been dropped successfully. Run `show-quick-demo-stack-on-aws.sh` until you get a `Stack with id quick-demo-001 does not exist` error message:
   ```
   $ ./show-quick-demo-stack-on-aws.sh
   An error occurred (ValidationError) when calling the DescribeStacks operation: Stack with id quick-demo-001 does not exist
   ```