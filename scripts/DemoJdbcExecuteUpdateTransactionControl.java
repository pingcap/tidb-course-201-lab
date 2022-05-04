import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DemoJdbcExecuteUpdateTransactionControl{

    public static void printResultSetStringString(String stmtText, Connection connection) {
        int count = 0;
        System.out.println("\n/* Executing query: "+stmtText+"; */");
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(stmtText);
            System.out.println("Row#, "+resultSet.getMetaData().getColumnName(1)+", "+resultSet.getMetaData().getColumnName(2));
            while (resultSet.next()) {
                System.out.println((++count) + ") " + resultSet.getString(1)+", "+resultSet.getString(2));
            }
            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            System.out.println("Error: "+e);
        }
    }

    public static void main(String[] args){
        Connection connection = null;
        Statement statement = null;
        String offAutoCommit = "SET @@autocommit = 0";
        String onAutoCommit = "SET @@autocommit = 1";
        try{
            connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:4000/test?useServerPrepStmts=true&cachePrepStmts=true&rewriteBatchedStatements=true", "root", ""
            );
            System.out.println("Connection established.");
            
            statement = connection.createStatement();
            // Prepare
            statement.executeUpdate("DROP TABLE IF EXISTS t1");
            statement.executeUpdate("CREATE TABLE t1 (id bigint PRIMARY KEY AUTO_RANDOM, name char(4))");
            System.out.println("Table test.t1 created.");
            // Turn off autocommit
            statement.executeUpdate(offAutoCommit);
            System.out.println("Turn off autocommit.");
            // DML: inserting
            int rowCount = 0;
            rowCount = statement.executeUpdate("INSERT INTO t1 (name) VALUES('ABCD')");
            statement.executeUpdate("COMMIT");
            System.out.println(rowCount+" row inserted into table test.t1 (commit).");
            rowCount = statement.executeUpdate("INSERT INTO t1 (name) VALUES('EFGH')");
            statement.executeUpdate("COMMIT");
            System.out.println(rowCount+" row inserted into table test.t1 (commit).");
            rowCount = statement.executeUpdate("INSERT INTO t1 (name) VALUES('IJKL'), ('MNOP')");
            statement.executeUpdate("COMMIT");
            System.out.println(rowCount+" row inserted into table test.t1 (commit).");
            // Finish
        }
        catch(SQLException e){
            System.out.println("Error: "+e);
            // Try something
            if(connection != null && statement != null){
                try{
                    statement.executeUpdate("ROLLBACK");
                    System.out.println("Transaction rolled back.");
                }
                catch(SQLException e2){
                    System.out.println("Error: "+e2);
                }
            }
        }
        finally{
            if(connection != null){
                try{
                    // Check the battle field
                    printResultSetStringString("select * from test.t1", connection);
                    // Turn on autocommit
                    statement.executeUpdate(onAutoCommit);
                    System.out.println("Turn on autocommit.");
                    connection.close();
                    System.out.println("Connection closed.");
                }
                catch(Exception e){
                    System.out.println("Error disconnecting: "+e.toString());
                }
            }
            else{
                System.out.println("Already disconnected.");
            }
        }
    }
}