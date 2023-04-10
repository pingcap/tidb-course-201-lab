import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

public class DemoJdbcEndlessInsertDummyV2 {

    public static void main(String[] args) {
        Runnable[] workers = new Runnable[] { new InsertWorker1(), new InsertWorker2(), new InsertWorker3() };
        for (Runnable worker:workers){
            new Thread(worker).start();
        }
    }
}

class InsertWorker1 implements Runnable {

    @Override
    public void run() {
        String[] portNumbers = new String[] { "4000", "4001", "4002" };
        Connection connection = null;
        while (true) {
            for (String portNumber : portNumbers) {
                String connectionString = "jdbc:mysql://127.0.0.1:" + portNumber
                        + "/test?useServerPrepStmts=true&cachePrepStmts=true";
                System.out.println("Connecting by " + connectionString);
                try {
                    connection = DriverManager.getConnection(
                            connectionString,
                            "root", "");
                    System.out.println("Connection established.");
                    // Do something in the connection
                    String sqlInsertIntoTable = "INSERT INTO test.dummy (name) VALUES (?)";
                    PreparedStatement ps = connection.prepareStatement(sqlInsertIntoTable);
                    String d = null;
                    while (true) {
                        try {
                            Thread.sleep(500);
                        } catch (Exception e) {
                            // Do nonthing
                        }
                        d = new Date().toString();
                        ps.setString(1, new Date().toString());
                        ps.executeUpdate();
                        System.out.println("INSERT INTO test.dummy (name) VALUES ('" + d + "')");
                    }
                } catch (SQLException e) {
                    System.out.println("Error from Worker1: " + e);
                }
            }
        }
    }
}

class InsertWorker2 implements Runnable {

    @Override
    public void run() {
        String[] portNumbers = new String[] { "4001", "4002", "4000" };
        Connection connection = null;
        while (true) {
            for (String portNumber : portNumbers) {
                String connectionString = "jdbc:mysql://127.0.0.1:" + portNumber
                        + "/test?useServerPrepStmts=true&cachePrepStmts=true";
                System.out.println("Connecting by " + connectionString);
                try {
                    connection = DriverManager.getConnection(
                            connectionString,
                            "root", "");
                    System.out.println("Connection established.");
                    // Do something in the connection
                    String sqlInsertIntoTable = "INSERT INTO test.dummy (name) VALUES (?)";
                    PreparedStatement ps = connection.prepareStatement(sqlInsertIntoTable);
                    String d = null;
                    while (true) {
                        try {
                            Thread.sleep(500);
                        } catch (Exception e) {
                            // Do nonthing
                        }
                        d = new Date().toString();
                        ps.setString(1, new Date().toString());
                        ps.executeUpdate();
                        System.out.println("INSERT INTO test.dummy (name) VALUES ('" + d + "')");
                    }
                } catch (SQLException e) {
                    System.out.println("Error from Worker2: " + e);
                }
            }
        }
    }

}

class InsertWorker3 implements Runnable {

    @Override
    public void run() {
        String[] portNumbers = new String[] { "4002", "4000", "4001" };
        Connection connection = null;
        while (true) {
            for (String portNumber : portNumbers) {
                String connectionString = "jdbc:mysql://127.0.0.1:" + portNumber
                        + "/test?useServerPrepStmts=true&cachePrepStmts=true";
                System.out.println("Connecting by " + connectionString);
                try {
                    connection = DriverManager.getConnection(
                            connectionString,
                            "root", "");
                    System.out.println("Connection established.");
                    // Do something in the connection
                    String sqlInsertIntoTable = "INSERT INTO test.dummy (name) VALUES (?)";
                    PreparedStatement ps = connection.prepareStatement(sqlInsertIntoTable);
                    String d = null;
                    while (true) {
                        try {
                            Thread.sleep(500);
                        } catch (Exception e) {
                            // Do nonthing
                        }
                        d = new Date().toString();
                        ps.setString(1, new Date().toString());
                        ps.executeUpdate();
                        System.out.println("INSERT INTO test.dummy (name) VALUES ('" + d + "')");
                    }
                } catch (SQLException e) {
                    System.out.println("Error from Worker3: " + e);
                }
            }
        }
    }

}
