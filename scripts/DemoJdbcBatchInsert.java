import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

/**
 * JDBC parameter: rewriteBatchedStatements=true|false.
 */

public class DemoJdbcBatchInsert {

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

        if (args == null || args.length == 0
                || (!args[0].equalsIgnoreCase("cloud") && !args[0].equalsIgnoreCase("local"))) {
            System.out.println("Please specify either CLOUD or LOCAL as the demo target.");
            System.exit(-1);
        }

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

        try {
            for (String flag : new String[] { "true", "false" }) {
                connection = DriverManager.getConnection(
                        "jdbc:mysql://" + tidbHost
                                + ":" + port
                                + "/test?useServerPrepStmts=true&cachePrepStmts=true&rewriteBatchedStatements=" + flag,
                        dbUsername, dbPassword);
                System.out.println("Connection established.");
                // Prepare the table in the connection
                String sqlDropTable = "DROP TABLE IF EXISTS t1_batchtest";
                String sqlCreateTable = "CREATE TABLE t1_batchtest (id int primary key, name char(30))";
                PreparedStatement[] pss = new PreparedStatement[] {
                        connection.prepareStatement(sqlDropTable),
                        connection.prepareStatement(sqlCreateTable)
                };
                for (PreparedStatement ps : pss) {
                    ps.executeUpdate();
                    ps.close();
                }
                // Batch PS
                connection.setAutoCommit(true);
                PreparedStatement insert1_ps = connection.prepareStatement("INSERT INTO t1_batchtest VALUES (?, ?)");
                System.out.println(">>> Begin insert 10000 rows.");
                long s1 = System.currentTimeMillis();
                for (int i = 1; i < 10001; i++) {
                    insert1_ps.setInt(1, i);
                    insert1_ps.setString(2, Integer.toString(i));
                    insert1_ps.addBatch();
                }
                insert1_ps.executeBatch();
                System.out.println(
                        ">>> End batch insert,rewriteBatchedStatements=" + flag + ",elapsed: "
                                + Long.toString(System.currentTimeMillis() - s1) + " (ms).");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e);
            // Try something
            if (connection != null) {
                try {
                    connection.rollback();
                    System.out.println("Transaction rolled back.");
                } catch (SQLException e2) {
                    System.out.println("Error: " + e2);
                }
            }
        } finally {
            if (connection != null) {
                try {
                    // Check the battle field
                    printResultSetStringString("select count(*), max(name) from test.t1_batchtest", connection);
                    // Turn on autocommit
                    connection.setAutoCommit(true);
                    System.out.println("Turn on autocommit.");
                    connection.close();
                    System.out.println("Connection closed.");
                } catch (Exception e) {
                    System.out.println("Error disconnecting: " + e.toString());
                }
            } else {
                System.out.println("Already disconnected.");
            }
        }
    }
}