# Notes
1. **DO NOT** deploy the demo Cloud Formation in production environment. You are at your own risk.
2. This demo requires **Python3** and **boto3** installed on your local machine.
3. You need an active AWS account for testing purposes. And, your IAM user or role should have the permissions to create various AWS resources, it should be an admin IAM user/role or a power user/role. The identity you use must have the permissions to manage following services or resources: IAM roles, VPC, EC2, ELB, SQS, Lambda, IAM roles, CloudWatch, CloudWatch Logs, Auto Scaling Group, EventBridge, CloudFormation. 
4. **MAKE SURE** you also follow the instructions to tear down the demo environment after the showcase, otherwise AWS will keep charging you.
5. Estimated demo cost: ~2 USD.

# Demo Preparation
1. Setup EC2 instance SSH identity:

   a. On EC2 console, go to region "us-west-2" (Oregon). Under `Key Pairs` section, create a new key pair with name `pe-class-key`, and save the private key file (for example: `pe-class-key.pem`) to local directory `~/.ssh/`.

   b. Change the private key file permission to `r--`:
    ```
    $ chmod 400 ~/.ssh/pe-class-key.pem
    ```

2. Setup AWS credentials for your terminal.
   
   a. If you use permenant IAM power user, follow the [instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html) to set up the **default** awscli profile.
   b. If you use temporary IAM power user or IAM role, set your credentials to following environment variables in your local terminal:
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
    # Reporting End - 2023-05-08 11:47:38.302259 with 10 nodes.
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
    Total nodes: 12
    ```

# Demo Workflow
1. TODO

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