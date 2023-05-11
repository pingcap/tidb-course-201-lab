import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

public class DemoJdbcEndlessInsertDummyCSPWithLB {

    public static void main(String[] args) {
        Thread[] workers = new Thread[] { new InsertWorkerCSP1(args[0]), new InsertWorkerCSP2(args[0]),
                new InsertWorkerCSP3(args[0]), new InsertWorkerCSP4(args[0]) };
        for (Thread worker : workers) {
            new Thread(worker).start();
        }
    }
}

class InsertWorkerCSP1 extends Thread {

    private String lbName;

    public InsertWorkerCSP1(String lbName) {
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
                if (dateTime == null) {
                    dateTime = new Date().toString();
                }
                ps.setString(1, "worker1");
                ps.setString(2, "time");
                ps.setString(3, dateTime);
                ps.setString(4, "interval");
                ps.setInt(5, interval);
                ps.setQueryTimeout(1);
                ps.executeUpdate();
                dateTime = null;
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

class InsertWorkerCSP2 extends Thread {

    private String lbName;

    public InsertWorkerCSP2(String lbName) {
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
                if (dateTime == null) {
                    dateTime = new Date().toString();
                }
                ps.setString(1, "worker2");
                ps.setString(2, "time");
                ps.setString(3, dateTime);
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

class InsertWorkerCSP3 extends Thread {

    private String lbName;

    public InsertWorkerCSP3(String lbName) {
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
                if (dateTime == null) {
                    dateTime = new Date().toString();
                }
                ps.setString(1, "worker3");
                ps.setString(2, "time");
                ps.setString(3, dateTime);
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

class InsertWorkerCSP4 extends Thread {

    private String lbName;

    public InsertWorkerCSP4(String lbName) {
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
                if (dateTime == null) {
                    dateTime = new Date().toString();
                }
                ps.setString(1, "worker4");
                ps.setString(2, "time");
                ps.setString(3, dateTime);
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
