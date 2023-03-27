import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class DemoJdbcEMPWorkload {
    public static void main(String[] args) {
        Connection connection = null;
        String username = "emp_app";
        try {
            connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:4000/emp", username, "tidb");
            Statement statement = connection.createStatement();
            int rowCount = 0;
            long startTime = 0L;
            for (int i = 0; i < 50; i++) {
                startTime = System.currentTimeMillis();
                rowCount = statement.executeUpdate("UPDATE emp SET commission = " + (i / 100));
                System.out.println("UPDATE - (" + i + ")" +
                        username + " processed " + rowCount + " rows, elapsed time: " + (System.currentTimeMillis()
                                - startTime)
                        + " ms");
            }
            statement.close();
            // Finish
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                    System.out.println(username + " connection closed at " + new Date());
                } catch (Exception e) {
                    System.out.println("Error disconnecting: " + e.toString());
                }
            } else {
                System.out.println("Already disconnected.");
            }
        }
    }
}