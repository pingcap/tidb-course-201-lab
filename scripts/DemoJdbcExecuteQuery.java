import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DemoJdbcExecuteQuery {

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
        try {
            connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:4000/test", "root", "");
            System.out.println("Connection established.");
            // Do something in the connection.
            // Show autocommit
            printResultSetStringString("show variables like 'autocommit'", connection);
            // Create table
            connection.createStatement().executeUpdate("DROP TABLE IF EXISTS t1");
            connection.createStatement().executeUpdate("CREATE TABLE t1 (id int PRIMARY KEY, name char(4))");
            // Describe table
            printResultSetStringString("describe test.t1", connection);
            // Explain SQL
            printResultSetStringString("explain select * from test.t1", connection);
            // Select
            printResultSetStringString("select * from test.t1", connection);
            // Try DML
            printResultSetStringString("insert into test.t1 values (100, 'WXYZ')", connection);
            // Select
            printResultSetStringString("select * from test.t1", connection);
            // Finishing.
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        } finally {
            if (connection != null) {
                try {
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