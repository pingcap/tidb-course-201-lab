import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

public class DemoJdbcEndlessInsertDummyCSPWithLB {

    public static void main(String[] args) {
        Thread[] workers = new Thread[] { new InsertWorker1(args[0]), new InsertWorker2(args[0]),
                new InsertWorker3(args[0]), new InsertWorker4(args[0]) };
        for (Thread worker : workers) {
            new Thread(worker).start();
        }
    }
}

class InsertWorker1 extends Thread {

    private String lbName;

    public InsertWorker1(String lbName) {
        super();
        this.lbName = lbName;
    }

    @Override
    public void run() {
        String connectionString = null;
        Connection connection = null;
        int interval = 0;
        String sqlInsertIntoTable = null;
        PreparedStatement ps = null;
        String dateTime = null;
        String hostName = this.lbName;
        boolean exceptionBackoff = false;
        while (true) {
            try {
                connectionString = "jdbc:mysql://" + hostName + ":" + "4000"
                        + "/test?useServerPrepStmts=true&cachePrepStmts=true&queryTimeoutKillsConnection=true&connectTimeout=1000";
                DriverManager.setLoginTimeout(1);
                connection = DriverManager.getConnection(
                        connectionString,
                        "root", "");
                // Do something in the connection
                sqlInsertIntoTable = "INSERT INTO test.dummy (name, event, tidb_instance) VALUES (?,JSON_OBJECT(?,?,?,?), (SELECT instance FROM information_schema.cluster_processlist WHERE host=(SELECT host FROM information_schema.processlist WHERE id=CONNECTION_ID())))";
                ps = connection.prepareStatement(sqlInsertIntoTable);
                dateTime = new Date().toString();
                ps.setString(1, "worker1");
                ps.setString(2, "time");
                ps.setString(3, new Date().toString());
                ps.setString(4, "interval");
                ps.setInt(5, interval);
                ps.setQueryTimeout(1);
                ps.executeUpdate();
                System.out.println(
                        "Worker 1 -> TiDB:" + dateTime + " at " + hostName);
                if (!exceptionBackoff) {
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        continue;
                    }
                }
                exceptionBackoff = false;
            } catch (SQLException e) {
                exceptionBackoff = true;
                continue;
            }
        }
    }
}

class InsertWorker2 extends Thread {

    private String lbName;

    public InsertWorker2(String lbName) {
        super();
        this.lbName = lbName;
    }

    @Override
    public void run() {
        String connectionString = null;
        Connection connection = null;
        int interval = 0;
        String sqlInsertIntoTable = null;
        PreparedStatement ps = null;
        String dateTime = null;
        String hostName = this.lbName;
        boolean exceptionBackoff = false;
        while (true) {
            try {
                connectionString = "jdbc:mysql://" + hostName + ":" + "4000"
                        + "/test?useServerPrepStmts=true&cachePrepStmts=true&queryTimeoutKillsConnection=true&connectTimeout=1000";
                DriverManager.setLoginTimeout(1);
                connection = DriverManager.getConnection(
                        connectionString,
                        "root", "");
                // Do something in the connection
                sqlInsertIntoTable = "INSERT INTO test.dummy (name, event, tidb_instance) VALUES (?,JSON_OBJECT(?,?,?,?), (SELECT instance FROM information_schema.cluster_processlist WHERE host=(SELECT host FROM information_schema.processlist WHERE id=CONNECTION_ID())))";
                ps = connection.prepareStatement(sqlInsertIntoTable);
                dateTime = new Date().toString();
                ps.setString(1, "worker2");
                ps.setString(2, "time");
                ps.setString(3, new Date().toString());
                ps.setString(4, "interval");
                ps.setInt(5, interval);
                ps.setQueryTimeout(1);
                ps.executeUpdate();
                System.out.println(
                        "Worker 2 -> TiDB:" + dateTime + " at " + hostName);
                if (!exceptionBackoff) {
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        continue;
                    }
                }
                exceptionBackoff = false;
            } catch (SQLException e) {
                exceptionBackoff = true;
                continue;
            }
        }
    }
}

class InsertWorker3 extends Thread {

    private String lbName;

    public InsertWorker3(String lbName) {
        super();
        this.lbName = lbName;
    }

    @Override
    public void run() {
        String connectionString = null;
        Connection connection = null;
        int interval = 0;
        String sqlInsertIntoTable = null;
        PreparedStatement ps = null;
        String dateTime = null;
        String hostName = this.lbName;
        boolean exceptionBackoff = false;
        while (true) {
            try {
                connectionString = "jdbc:mysql://" + hostName + ":" + "4000"
                        + "/test?useServerPrepStmts=true&cachePrepStmts=true&queryTimeoutKillsConnection=true&connectTimeout=1000";
                DriverManager.setLoginTimeout(1);
                connection = DriverManager.getConnection(
                        connectionString,
                        "root", "");
                // Do something in the connection
                sqlInsertIntoTable = "INSERT INTO test.dummy (name, event, tidb_instance) VALUES (?,JSON_OBJECT(?,?,?,?), (SELECT instance FROM information_schema.cluster_processlist WHERE host=(SELECT host FROM information_schema.processlist WHERE id=CONNECTION_ID())))";
                ps = connection.prepareStatement(sqlInsertIntoTable);
                dateTime = new Date().toString();
                ps.setString(1, "worker3");
                ps.setString(2, "time");
                ps.setString(3, new Date().toString());
                ps.setString(4, "interval");
                ps.setInt(5, interval);
                ps.setQueryTimeout(1);
                ps.executeUpdate();
                System.out.println(
                        "Worker 3 -> TiDB:" + dateTime + " at " + hostName);
                if (!exceptionBackoff) {
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        continue;
                    }
                }
                exceptionBackoff = false;
            } catch (SQLException e) {
                exceptionBackoff = true;
                continue;
            }
        }
    }
}

class InsertWorker4 extends Thread {

    private String lbName;

    public InsertWorker4(String lbName) {
        super();
        this.lbName = lbName;
    }

    @Override
    public void run() {
        String connectionString = null;
        Connection connection = null;
        int interval = 0;
        String sqlInsertIntoTable = null;
        PreparedStatement ps = null;
        String dateTime = null;
        String hostName = this.lbName;
        boolean exceptionBackoff = false;
        while (true) {
            try {
                connectionString = "jdbc:mysql://" + hostName + ":" + "4000"
                        + "/test?useServerPrepStmts=true&cachePrepStmts=true&queryTimeoutKillsConnection=true&connectTimeout=1000";
                DriverManager.setLoginTimeout(1);
                connection = DriverManager.getConnection(
                        connectionString,
                        "root", "");
                // Do something in the connection
                sqlInsertIntoTable = "INSERT INTO test.dummy (name, event, tidb_instance) VALUES (?,JSON_OBJECT(?,?,?,?), (SELECT instance FROM information_schema.cluster_processlist WHERE host=(SELECT host FROM information_schema.processlist WHERE id=CONNECTION_ID())))";
                ps = connection.prepareStatement(sqlInsertIntoTable);
                dateTime = new Date().toString();
                ps.setString(1, "worker4");
                ps.setString(2, "time");
                ps.setString(3, new Date().toString());
                ps.setString(4, "interval");
                ps.setInt(5, interval);
                ps.setQueryTimeout(1);
                ps.executeUpdate();
                System.out.println(
                        "Worker 4 -> TiDB:" + dateTime + " at " + hostName);
                if (!exceptionBackoff) {
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        continue;
                    }
                }
                exceptionBackoff = false;
            } catch (SQLException e) {
                exceptionBackoff = true;
                continue;
            }
        }
    }
}
