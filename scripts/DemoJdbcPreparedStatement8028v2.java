import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class DemoJdbcPreparedStatement8028v2 {

    static int I;
    static String MAIN_TASK = "INSERT INTO t1(num) VALUES (100);";

    public static void main(String[] args) throws InterruptedException {

        String tidbHost = args[0];
        String port = args[1];
        String dbUsername = args[2];
        String securityOption = null;
        String dbPassword = null;
        int errorCodeToHandleOnce = 8028;

        Connection connection = null;
        try {
            connection = DriverManager.getConnection(
                    "jdbc:mysql://" + tidbHost + ":" + port + "/demo?useServerPrepStmts=true&cachePrepStmts=true",
                    dbUsername,
                    dbPassword);
            System.out.println("Connection established.");
            connection.setAutoCommit(false);

            // Start workload
            PreparedStatement psMainInsert = connection.prepareStatement(MAIN_TASK);
            for (int i = 0; i < 2000000; i++) {
                I = i;
                System.out.println(i + " rows to be inserted." );
                psMainInsert.executeUpdate();
                Thread.sleep(1000);
                connection.commit();
            }
        } catch (SQLException e) {
            System.out.println("Main task error.");
            System.out.println("Error: " + e);
            System.out.println("SQLState: " + e.getSQLState());
            System.out.println("ErrorCode: " + e.getErrorCode());
            e.printStackTrace();
            if (connection != null) {
                try {
                    if (e.getErrorCode() == errorCodeToHandleOnce) {
                        if (e.getErrorCode() == 8028) {
                            System.out.println("8028 (schema mutation) encountered, backoff...");
                        }
                        System.out.println(
                                "DO anything in reaction to error, in this example we continue our workload.");
                        Thread.sleep(3000);
                        connection.rollback();
                        PreparedStatement psMainInsert = connection.prepareStatement(MAIN_TASK);
                        for (int i = I; i < 200000; i++) {
                            I = i;
                            System.out.println(i + " rows to be inserted." );
                            psMainInsert.executeUpdate();
                            connection.commit();
                            Thread.sleep(1000);
                        }
                    }
                } catch (SQLException e2) {
                    System.out.println("TX Rollback error.");
                    System.out.println("Error: " + e);
                    System.out.println("SQLState: " + e.getSQLState());
                    System.out.println("ErrorCode: " + e.getErrorCode());
                    e.printStackTrace();
                }
            }
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                    System.out.println("Connection closed.");
                } catch (SQLException e) {
                    System.out.println("Disconnecting error.");
                    System.out.println("Error: " + e);
                    System.out.println("SQLState: " + e.getSQLState());
                    System.out.println("ErrorCode: " + e.getErrorCode());
                    e.printStackTrace();
                }
            } else {
                System.out.println("Already disconnected.");
            }
        }
    }
}