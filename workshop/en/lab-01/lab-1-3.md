# Create a Developer Tier Cluster

1. On the `Active Clusters` page, click `Create Cluster`.
<img src="./diagram/ch01-03.png" width="50%" align="top"/>

2. On the Create Cluster page, select `Developer Tier` and set the `Cluster Name`, choose a Cloud provider `Region` and then click `Create`.
Note that the Developer Tier clusters cannot modify `Cloud Provider`, `Node Size`, `Storage Size` and `Node Quantity`.
<img src="./diagram/ch01-04.png" width="50%" align="top"/>  

3. In the Security Settings window, set the `Root Password to access the cluster` and `Add entries to your IP Access List`, and then click `Apply`.
<img src="./diagram/ch01-05.png" width="50%" align="top"/>

4. Wait for your TiDB Cloud cluster to be created. (approximately 10 to 30 minutes)
<img src="./diagram/ch01-06.png" width="50%" align="top"/>
<img src="./diagram/ch01-07.png" width="50%" align="top"/>

5. In the Active Clusters tab, click `Connect`.
<img src="./diagram/ch02-1-01.png" width="50%" align="top"/>

6. In the Connect setting window, click one of the buttons to add some rules, set the `IP Address` and `Description(Optional)`, and then click `Update Filter` to confirm the changes. If the traffic filter is already set, you can edit it or skip this step.               
<img src="./diagram/ch02-1-03.png" width="50%" align="top"/>
<img src="./diagram/ch02-1-04.png" width="50%" align="top"/>

7. Note down the value of hostname, username and port number, as you will use them later. 
<img src="./diagram/ch02-1-05.png" width="50%" align="top"/>

8. Set environment variables for connecting to TiDB Cloud cluster you created in previous steps:
```
$ export TIDB_CLOUD_HOST=<TiDB Cloud cluster hostname>
$ export TIDB_CLOUD_USERNAME=<database username>
$ export TIDB_CLOUD_PASSWORD=<user password>
$ export TIDB_CLOUD_PORT=<port number>
```
