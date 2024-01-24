import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DemoJdbcConnectionIncorrect {
    public static void main(String[] args) {
        Connection connection = null;
        try {
            // Connect to TiDB server instance directly
            connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:4000/test", "root", "");
            System.out.println("Connection established.");
        } catch (Exception e) {
            System.out.println("Error: " + e);
        } finally {
            if (connection != null) {
                try {
                    // Release the resources in cascade
                    connection.close();
                    System.out.println("Connection closed.");
                } catch (SQLException e) {
                    System.out.println("Error disconnecting: " + e.toString());
                }
            } else {
                System.out.println("Already disconnected.");
            }
        }
    }
}