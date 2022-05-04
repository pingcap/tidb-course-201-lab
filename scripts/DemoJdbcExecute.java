import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;

/**
 * Execute multi-statement?
 *   Error: java.sql.SQLException: client has multi-statement capability disabled.
 *   Run SET GLOBAL tidb_multi_statement_mode='ON' after you understand the security risk.
 */

public class DemoJdbcExecute {

    public static void printResultSetStringString(String stmtText, Connection connection) {
        int count = 0;
        System.out.println("\n/* Executing: "+stmtText+"; */");
        try {
            Statement statement = connection.createStatement();
            Boolean isResultSet = statement.execute(stmtText);
            if (isResultSet){
                ResultSet resultSet = statement.getResultSet();
                System.out.println("\tRow#,  "+resultSet.getMetaData().getColumnName(1)+", "+resultSet.getMetaData().getColumnName(2));
                while (resultSet.next()) {
                    System.out.println("\t"+(++count) + ") " + resultSet.getString(1)+", "+resultSet.getString(2));
                }    
                resultSet.close();
            }
            statement.close();
        } catch (Exception e) {
            System.out.println("Error: "+e.toString());
        }
    }

    public static void main(String[] args) {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:4000/test?useServerPrepStmts=true", "root", "");
            System.out.println("Connection established.");
            // Turn on multi-statement
            printResultSetStringString("SET tidb_multi_statement_mode='ON'", connection);
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
            printResultSetStringString("insert into test.t1 values (100, 'WXYZ'); insert into test.t1 values (200, 'ABCD')", connection);
            // Select again
            printResultSetStringString("select * from test.t1", connection);
            // Finishing.
        } catch (Exception e) {
            System.out.println("Error: " + e.toString());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                    System.out.println("Connection closed.");
                } catch (Exception e) {
                    System.out.println("Error disconnecting: " + e.toString());
                }
            }
            else{
                System.out.println("Already disconnected.");
            }
        }
    }
}