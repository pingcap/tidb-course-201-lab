import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class DemoJdbcPreparedStatement8028 {

    static int I;
    static String MAIN_TASK = "INSERT INTO test.target_table (id, name1) SELECT NULL, name FROM test.seed";

    /**
     * Print result set for single Long column.
     * 
     * @param stmtText
     * @param connection
     */
    public static void printResultSetLong(String stmtText, Connection connection) {
        int count = 0;
        System.out.println("\n/* Executing query: " + stmtText + "; */");
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(stmtText);
            System.out.println("\tRow#, " + resultSet.getMetaData().getColumnName(1));
            while (resultSet.next()) {
                System.out.println("\t" + (++count) + ") " + resultSet.getLong(1));
            }
            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
    }

    /**
     * Print result set for two String columns.
     * 
     * @param stmtText
     * @param connection
     */
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

    public static void main(String[] args) throws InterruptedException {
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
        String securityOption = null;
        if (target.equalsIgnoreCase("cloud")) {
            tidbHost = tidbCloudHost;
            dbUsername = dbCloudUsername;
            dbPassword = dbCloudPassword;
            port = dbCloudPort;
            securityOption = "&sslMode=VERIFY_IDENTITY&enabledTLSProtocols=TLSv1.3";
        } else {
            tidbHost = tidbOpHost;
            dbUsername = dbOpUsername;
            dbPassword = dbOpPassword;
            port = dbOpPort;
            securityOption = "";
        }
        System.out.println("TiDB endpoint: " + tidbHost);
        System.out.println("TiDB username: " + dbUsername);
        System.out.println("Default TiDB server port: " + port);
        System.out.println("Security options: " + securityOption);
        int errorCodeToHandleOnce = 0;
        if (args != null && args.length > 1) {
            errorCodeToHandleOnce = Integer.parseInt(args[1]);
        }
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(
                    "jdbc:mysql://" + tidbHost + ":" + port + "/test?useServerPrepStmts=true&cachePrepStmts=true"
                            + securityOption,
                    dbUsername,
                    dbPassword);
            System.out.println("Connection established.");
            // Setup
            String sqlDropTable = "DROP TABLE IF EXISTS test.target_table";
            String sqlCreateTable = "CREATE TABLE test.target_table(id BIGINT PRIMARY KEY AUTO_RANDOM, name1 CHAR(20))";
            String sqlDropSeedTable = "DROP TABLE IF EXISTS test.seed";
            String sqlCreateSeedTable = "CREATE TABLE test.seed(name CHAR(20))";
            String sqlInsertIntoSeed = "INSERT INTO test.seed (name) VALUES ('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL')";
            PreparedStatement[] pss = new PreparedStatement[] {
                    connection.prepareStatement(sqlDropTable),
                    connection.prepareStatement(sqlCreateTable),
                    connection.prepareStatement(sqlDropSeedTable),
                    connection.prepareStatement(sqlCreateSeedTable),
                    connection.prepareStatement(sqlInsertIntoSeed)
            };
            for (PreparedStatement ps : pss) {
                ps.executeUpdate();
                ps.close();
            }
            // Populate Seed
            connection.setAutoCommit(false);
            String sqlDoubleSeed = "INSERT INTO test.seed SELECT * FROM test.seed";
            PreparedStatement psDoubleSeed = connection.prepareStatement(sqlDoubleSeed);
            for (int i = 0; i < 6; i++) {
                System.out.println("populating");
                psDoubleSeed.executeUpdate();
                connection.commit();
            }
            printResultSetLong("SELECT count(*) AS \"|320|\" FROM test.seed", connection);
            printResultSetStringString("DESC test.target_table", connection);
            Thread.sleep(5000);
            // Start workload
            connection.commit();
            PreparedStatement psMainInsert = connection.prepareStatement(MAIN_TASK);
            for (int i = 0; i < 200; i++) {
                I = i;
                System.out.println("Main task workload ..." + i);
                for (int k = 0; k < 3; k++) {
                    psMainInsert.executeUpdate();
                }
                connection.commit();
                System.out.println("Main task workload commit ...");
                printResultSetStringString(
                        "SELECT name1 AS \"|NAME1|\", COUNT(*) AS \"|BEFORE-DDL-GOAL: 192000|\" FROM test.target_table GROUP BY name1 ORDER BY 1",
                        connection);
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
                        Thread.sleep(5000);
                        connection.rollback();
                        PreparedStatement psMainInsert = connection.prepareStatement(MAIN_TASK);
                        for (int i = I; i < 200; i++) {
                            I = i;
                            System.out.println("Main task workload ..." + i);
                            for (int k = 0; k < 3; k++) {
                                psMainInsert.executeUpdate();
                            }
                            connection.commit();
                            System.out.println("Main task workload commit ...");
                            printResultSetStringString(
                                    "SELECT name1 AS \"|NAME1|\", COUNT(*) AS \"|BEFORE-DDL-GOAL: 192000|\" FROM test.target_table GROUP BY name1 ORDER BY 1",
                                    connection);
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
                    connection.setAutoCommit(true);
                    System.out.println("Turn on autocommit.");
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