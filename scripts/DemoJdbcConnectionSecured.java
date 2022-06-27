import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DemoJdbcConnectionSecured {

    public static void printResultSetStringString(String stmtText, Connection connection) {
        int count = 0;
        System.out.println("\n/* Executing query: " + stmtText + "; */");
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(stmtText);
            System.out.println("\tRow#, " + resultSet.getMetaData().getColumnName(1) + ", "
                    + resultSet.getMetaData().getColumnName(2));
            while (resultSet.next()) {
                System.out.println("\t" + (++count) + ") " + resultSet.getString(1) + ", " + resultSet.getString(2));
            }
            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
    }

    public static void main(String[] args) {
        Connection connection = null;
        String[] mode = { "DISABLED", "REQUIRED", "PREFERRED", "VERIFY_CA", "VERIFY_IDENTITY" };
        for (String m : mode) {
            System.out.println("Trying with sslMode=" + m);
            try {
                // Connect to TiDB server instance directly
                connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:4000/test?enabledTLSProtocols=TLSv1.3&sslMode="+m, "root", "");
                System.out.println("Connection established.");
                printResultSetStringString("SHOW STATUS LIKE '%Ssl%'", connection);
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
}