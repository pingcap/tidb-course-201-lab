# Notes
1. **DO NOT** deploy the lab CloudFormation in production environment. You are at your own risk.
2. This lab setup requires **Python3**, **awscli**, and **boto3** installed on your local machine.
3. You need an active AWS account in order to run this setup. And, your IAM user or role should have the permissions to create various AWS resources, it should be an admin IAM user/role or a power user/role. The identity you use must have the permissions to manage following services or resources: IAM roles, VPC, EC2, ELB, SQS, Lambda, IAM roles, CloudWatch, CloudWatch Logs, Auto Scaling Group, EventBridge, CloudFormation. 
4. **MAKE SURE** you also follow the instructions to tear down the demo environment after the showcase, otherwise AWS will keep charging you.

# Lab Environment Preparation
1. Setup EC2 instance SSH identity:

    + a. On EC2 console, go to region "us-west-2" (Oregon). Under `Key Pairs` section, create a new key pair with name `pe-class-key`, and save the private key file (for example: `pe-class-key.pem`) to local directory `~/.ssh/`.

    + b. Change the private key file permission to `r--`:
      ```
      $ chmod 400 ~/.ssh/pe-class-key.pem
      ```

2. Setup AWS credentials for yourself.
   
    + a. If you use permenant IAM power user, follow the [instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html) to set up the **default** awscli profile.

    + b. If you use temporary IAM power user or IAM role, set your credentials to following environment variables in your local terminal:
      ```
      $ export AWS_ACCESS_KEY_ID="<YOUR_AWS_ACCESS_KEY_ID>"
      $ export AWS_SECRET_ACCESS_KEY="<YOUR_AWS_SECRECT_ACCESS_KEY>"
      $ export AWS_SESSION_TOKEN="<YOUR_SESSION_TOKEN>"
      ```

3. Create the class CloudFormation stack. Provide your name and your email as input parameters (for resource tagging purpose, otherwise the demo steps will fail). This stack will be created in "us-west-2" (Oregon) region:
    ```
    $ git clone https://github.com/pingcap/tidb-course-201-lab.git
    ```
    ```
    $ cd tidb-course-201-lab/tidb-quick-demo/303-tidb-admin-10-nodes-solo/setup
    ```
    ```
    $ ./deploy-lab-stack-on-aws.sh <YOUR_NAME> <YOUR_EMAIL>
    ```
    ```
    $ ./deploy-lab-stack-on-aws.sh gXXXXXXXo gXXXXXXXo@pXXXXXXXm
    {
        "StackId": "arn:aws:cloudformation:us-west-2:XXXXXXXXXX:stack/lab-303-v2/1aa6baa0-ee42-11ed-a1b9-06ee049f6e4d"
    }
    ```

4. Wait the CloudFormation stack run to completion. Run following script to check the status, until you get the `CREATE_COMPLETE` status on `StackStatus` attribute in the output. It will create 1 VPC, 4 subnets, 5 auto scaling groups:
    ```
    $ ./show-quick-demo-stack-on-aws.sh
    ``` 
    ```
    $ ./show-quick-demo-stack-on-aws.sh 
      {
          "Stacks": [
              {
                  "StackId": "arn:aws:cloudformation:us-west-2:XXXXXXXXXX:stack/lab-303-v2/1aa6baa0-ee42-11ed-a1b9-06ee049f6e4d",
                  "StackName": "lab-303-v2",
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

5. Launch and tag the class EC2 instances by running `class_start.sh <YOUR_NAME>`. This step will launch 10 EC2 instances:
    ```
    $ ./class_start.sh <YOUR_NAME>
    ```
    ```
      $ ./class_start.sh gXXXXXXXo

      ##################################################
      # Waiting for 150 seconds for nodes starting up. #
      ##################################################

      1 students with 1 monitor node(s).
      1 students with 3 pd node(s).
      1 students with 3 kv node(s).
      1 students with 2 db node(s).
      1 students with 1 tiflash node(s).
      Tagging i-0bb0553841ecc0451 with class-user1:monitor1
      Tagging monitor nodes completed.
      Tagging i-0823a3a917d5bf87f with class-user1:pd1
      Tagging i-0bd3492919928e185 with class-user1:pd2
      Tagging i-01847bab040690d96 with class-user1:pd3
      Tagging pd nodes completed.
      Tagging i-095a704ff26b8e4cf with class-user1:kv1
      Tagging i-015057ecff55e09b5 with class-user1:kv2
      Tagging i-056f185f8bfdfd293 with class-user1:kv3
      Tagging kv nodes completed.
      Tagging i-08151997dd939a6bd with class-user1:db1
      Tagging i-093c618d76e4e5b25 with class-user1:db2
      Tagging db nodes completed.
      Tagging i-04d8f0c4345244f51 with class-user1:tiflash1
      Tagging tiflash nodes completed.

      # Running Nodes for All Trainers.


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

      # Class Total Cost: 0.09999999999999999 (USD)

      # Reporting End - 2023-05-09 16:43:04.667293 with 10 nodes.
    ```

6. Add the private key identity to the SSH authentication agent:
    ```
    $ ssh-add ~/.ssh/pe-class-key.pem
    ```

7.  Provision the class cluster `tidb-test` topology by running `class_prepare.sh <YOUR_NAME>`:
    ```
    $ ./class_prepare.sh <YOUR_NAME>
    ```
    ```
    $ ./class_prepare.sh gXXXXXXXo
    Warning: Permanently added '18.x.x.163' (ED25519) to the list of known hosts.

    10 nodes are prepared for user user1 and trainer gXXXXXXXo.
    ...
    # Reporting End - 2023-05-08 11:47:38.302259 with 10 nodes.
    ```

# Tear Down the Lab Environment
1. On your local machine, under `setup` directory, run `remove-lab-stack-on-aws.sh` and `show-lab-stack-on-aws.sh`:
   ```
   $ cd setup/
   $ ./remove-lab-stack-on-aws.sh 
   $ ./show-lab-stack-on-aws.sh 
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

2. Verify that the CloudFormation stack had been dropped successfully. Run `show-lab-stack-on-aws.sh` until you get a `Stack with id lab-303-v2 does not exist` error message:
   ```
   $ ./show-lab-stack-on-aws.sh
   An error occurred (ValidationError) when calling the DescribeStacks operation: Stack with id lab-303-v2 does not exist
   ```