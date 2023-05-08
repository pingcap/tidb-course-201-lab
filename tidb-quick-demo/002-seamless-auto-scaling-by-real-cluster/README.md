# Notes
DO NOT RUN DEMO CLOUD FORMATION IN PRODUCTION ENVIRONMENT.

# Demo Preparation
1. First of all, you need an active AWS account for testing purposes.
2. Setup EC2 instance SSH identity:

   a. On EC2 console, go to region "us-west-2" (Oregon). Under `Key Pairs` section, create a new key pair with name `pe-class-key`, and save the private key file (for example: `pe-class-key.pem`) to local directory `~/.ssh/`.

   b. Change the private key permission to `r--`:
    ```
    $ chmod 400 ~/.ssh/pe-class-key.pem
    ```

3. Setup an EC2 instance IAM role:
   
   a. On IAM console, create a role for EC2 use case. Name it `pe-service-instance-role`. And, attach following permission policy: [_pe-service-instance-role_policy.json](lib/_pe-service-instance-role_policy.json) to this role.

3. Setup a Lambda IAM role:
4. Create the demo Cloud Formation stack:
5. Initialize the demo TiDB Cluster:

# Demo Workflow //TODO
1. Get the public ip of the monitor instance.
   ```
   $ ./check_nodes.sh | grep monitor
   ```
2. SSH (enabling forward) to the EC2 instance that tagged with "monitor"
    a. Add the private key identity to the SSH authentication agent:
      ```
      $ ssh-add ~/.ssh/pe-class-key.pem
      ``` 
    b. SSH into the `monitor` instance with forwarding enabeld:
      ```
      $ ssh -A ec2-user@<monitor_public_ip>
      ```
3. Make sure the Raft replicas setting is 3 and create the test table:
   1. On EC2 monitor instance terminal 1, execute: 
    ```
    $ ~/scripts/sd-002-csp-demo-workload-prepare.sh
    ```
4. EC2 monitor terminal 1: ~/scripts/sd-002-csp-demo-workload-start.sh
5. EC2 monitor terminal 2: ~/scripts/sd-002-csp-demo-workload-check.sh
6. EC2 monitor terminal 3: ~/scripts/sd-002-csp-demo-event-listener-start.sh
7. EC2 monitor terminal 4: ~/scripts/sd-002-csp-demo-hog-db.sh
8. EC2 monitor terminal 4: ~/scripts/sd-002-csp-demo-hog-kv.sh
