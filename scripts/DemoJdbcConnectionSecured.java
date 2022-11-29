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

        String target = args[0];
        String tidbCloudHost = System.getenv().get("TIDB_CLOUD_HOST");
        String tidbOpHost = System.getenv().get("TIDB_HOST") == null ? "127.0.0.1" : System.getenv().get("TIDB_HOST");
        String dbCloudUsername = System.getenv().get("TIDB_CLOUD_USERNAME") == null ? "root"
                : System.getenv().get("TIDB_CLOUD_USERNAME");
        String dbOpUsername = System.getenv().get("TIDB_USERNAME") == null ? "root"
                : System.getenv().get("TIDB_USERNAME");
        String dbCloudPassword = System.getenv().get("TIDB_CLOUD_PASSWORD") == null ? ""
                : System.getenv().get("TIDB_CLOUD_PASSWORD");
        String dbOpPassword = System.getenv().get("TIDB_PASSWORD") == null ? ""
                : System.getenv().get("TIDB_PASSWORD");
        String dbCloudPort = System.getenv().get("TIDB_CLOUD_PORT") == null ? "4000"
                : System.getenv().get("TIDB_CLOUD_PORT");
        String dbOpPort = System.getenv().get("TIDB_PORT") == null ? "4000"
                : System.getenv().get("TIDB_PORT");
        String tidbHost = null;
        String dbUsername = null;
        String dbPassword = null;
        String port = null;
        if (target.equalsIgnoreCase("cloud")) {
            tidbHost = tidbCloudHost;
            dbUsername = dbCloudUsername;
            dbPassword = dbCloudPassword;
            port = dbCloudPort;
        } else {
            tidbHost = tidbOpHost;
            dbUsername = dbOpUsername;
            dbPassword = dbOpPassword;
            port = dbOpPort;
        }
        System.out.println("TiDB endpoint: " + tidbHost);
        System.out.println("TiDB username: " + dbUsername);
        System.out.println("Default TiDB server port: " + port);

        Connection connection = null;
        String[] mode = { "DISABLED", "REQUIRED", "PREFERRED", "VERIFY_CA", "VERIFY_IDENTITY" };
        for (String m : mode) {
            System.out.println("\n\n### Trying with sslMode=" + m + " ###");
            try {
                // Connect to TiDB server instance directly
                connection = DriverManager.getConnection(
                        "jdbc:mysql://" + tidbHost + ":" + port + "/test?enabledTLSProtocols=TLSv1.2,TLSv1.3&sslMode="
                                + m,
                        dbUsername,
                        dbPassword);
                System.out.println("Connection established.");
                printResultSetStringString("SHOW STATUS LIKE '%Ssl%'", connection);
            } catch (Exception e) {
                System.out.println("Error: " + e);
                // e.printStackTrace();
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