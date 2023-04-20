import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.Random;

public class DemoJdbcEndlessInsertDummyCSP {

    public static void main(String[] args) {
        Runnable[] workers = new Runnable[] { new InsertWorker1(), new InsertWorker2() };
        for (Runnable worker : workers) {
            new Thread(worker).start();
        }
    }
}

class InsertWorker1 implements Runnable {

    @Override
    public void run() {
        String[] hosts = new String[] { System.getenv("HOST_DB1_PRIVATE_IP"),
                System.getenv("HOST_DB2_PRIVATE_IP") };
        String connectionString = null;
        Connection connection = null;
        Random rand = new Random();
        int interval = 0;
        String sqlInsertIntoTable = null;
        PreparedStatement ps = null;
        String dateTime = null;
        int c = 0;
        int j = 0;
        String hostName = null;
        while (true) {
            c++;
            try {
                hostName = hosts[c % 2];
                connectionString = "jdbc:mysql://" + hostName + ":" + "4000"
                        + "/test?useServerPrepStmts=true&cachePrepStmts=true&queryTimeoutKillsConnection=true";
                System.out.println("Worker 1 connection string: " + connectionString);
                DriverManager.setLoginTimeout(1);
                connection = DriverManager.getConnection(
                        connectionString,
                        "root", "");
                // Do something in the connection
                sqlInsertIntoTable = "INSERT INTO test.dummy (name, event) VALUES (?,JSON_OBJECT(?,?,?,?))";
                ps = connection.prepareStatement(sqlInsertIntoTable);
                while (true) {
                    j++;
                    try {
                        System.out.println("worker 1: " + c);
                        Thread.sleep(rand.nextInt(1000));
                        dateTime = new Date().toString();
                        ps.setString(1, "worker1");
                        ps.setString(2, "time");
                        ps.setString(3, new Date().toString());
                        ps.setString(4, "interval");
                        ps.setInt(5, interval);
                        ps.setQueryTimeout(1);
                        ps.executeUpdate();
                        System.out.println(
                                "Worker 1 - TiDB host:" + hostName
                                        + " - INSERTING at "
                                        + dateTime);
                        if (j % 10 == 0) {
                            break;
                        }
                    } catch (Exception e) {
                        System.out.println(
                                "Error - Worker 1 - TiDB host:" + hostName + " - "
                                        + e.getMessage() + " at "
                                        + dateTime);
                        connection.close();
                        break;
                    }
                }
            } catch (SQLException e) {
                System.out.println(
                        "Error - Worker 1 - TiDB host:" + hostName + " - "
                                + e.getMessage() + " at "
                                + dateTime);
                continue;
            }
        }
    }
}

class InsertWorker2 implements Runnable {

    @Override
    public void run() {
        String[] hosts = new String[] { System.getenv("HOST_DB2_PRIVATE_IP"),
                System.getenv("HOST_DB1_PRIVATE_IP") };
        String connectionString = null;
        Connection connection = null;
        Random rand = new Random();
        int interval = 0;
        String sqlInsertIntoTable = null;
        PreparedStatement ps = null;
        String dateTime = null;
        int c = 0;
        int j = 0;
        String hostName = null;
        while (true) {
            c++;
            try {
                hostName = hosts[c % 2];
                connectionString = "jdbc:mysql://" + hostName + ":" + "4000"
                        + "/test?useServerPrepStmts=true&cachePrepStmts=true&queryTimeoutKillsConnection=true";
                System.out.println("Worker 2 connection string: " + connectionString);
                DriverManager.setLoginTimeout(1);
                connection = DriverManager.getConnection(
                        connectionString,
                        "root", "");
                // Do something in the connection
                sqlInsertIntoTable = "INSERT INTO test.dummy (name, event) VALUES (?,JSON_OBJECT(?,?,?,?))";
                ps = connection.prepareStatement(sqlInsertIntoTable);
                while (true) {
                    j++;
                    try {
                        System.out.println("worker 2: " + c);
                        Thread.sleep(rand.nextInt(1000));
                        dateTime = new Date().toString();
                        ps.setString(1, "worker2");
                        ps.setString(2, "time");
                        ps.setString(3, new Date().toString());
                        ps.setString(4, "interval");
                        ps.setInt(5, interval);
                        ps.setQueryTimeout(1);
                        ps.executeUpdate();
                        System.out.println(
                                "Worker 2 - TiDB host:" + hostName
                                        + " - INSERTING at "
                                        + dateTime);
                        if (j % 10 == 0) {
                            break;
                        }
                    } catch (Exception e) {
                        System.out.println(
                                "Error - Worker 2 - TiDB host:" + hostName + " - "
                                        + e.getMessage() + " at "
                                        + dateTime);
                        connection.close();
                        break;
                    }
                }
            } catch (SQLException e) {
                System.out.println(
                        "Error - Worker 2 - TiDB host:" + hostName + " - "
                                + e.getMessage() + " at "
                                + dateTime);
                continue;
            }
        }
    }
}