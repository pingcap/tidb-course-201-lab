# Exercise 201.1.3 (Optional): Connecting to a TiDB Cluster Using mycli

## Purpose of the Exercise
+ `mycli` is a MySQL command line tool. Compared with other MySQL command line tools, `mycli` has two characteristics: one is to prompt and automatically complete SQL statements, and the other is syntax Highlight. For students who are not proficient in SQL statements, the user experience and learning speed can be greatly improved.

## Prerequisites
+ The TiDB cluster has been started and the **Exercise 201.1.2: Creating the `universe` Database in the TiDB Cluster** has been completed.
+ Internet connection.

## Steps

-----------------------------------------
#### 1. Install `mycli`
+ a. Install mycli directly from the terminal
  ```
  $ sudo apt install mycli
  ``` 
+ b. Install mycli using pip (requires python)
    ```
    sudo pip install mycli
    ```

-----------------------------------------
#### 2. Open a new session from the terminal and use mycli to access the TiDB test database
  ```
  $ mycli mysql://root@localhost:4000
  ``` 
