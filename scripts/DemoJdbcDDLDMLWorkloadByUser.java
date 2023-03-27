import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class DemoJdbcDDLDMLWorkloadByUser {
    public static void main(String[] args) {
        Connection connection = null;
        String username = args[0];
        try {
            connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:4000/test", username, "tidb");
            Statement statement = connection.createStatement();
            String tableName = username + "_table";
            statement.executeUpdate("DROP TABLE IF EXISTS " + tableName);
            statement.executeUpdate(
                    "CREATE TABLE " + tableName + " (id int PRIMARY KEY AUTO_INCREMENT, name char(255))");
            int rowCount = 0;
            long startTime = 0L;
            rowCount = statement.executeUpdate("INSERT INTO " + tableName
                    + " VALUES (NULL, 'ABCD'), (NULL, 'EFGH'), (NULL, 'IJKL'), (NULL, 'MNOP')");
            for (int i = 0; i < 17; i++) {
                startTime = System.currentTimeMillis();
                rowCount = statement.executeUpdate("INSERT INTO " + tableName
                        + " SELECT NULL, name FROM " + tableName);
            }
            System.out.println("# UPDATE: " + username);
            for (int i = 0; i < 4; i++) {
                startTime = System.currentTimeMillis();
                rowCount = statement.executeUpdate("UPDATE " + tableName
                        + " SET name = 'LIVESPACE" + i + "'");
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