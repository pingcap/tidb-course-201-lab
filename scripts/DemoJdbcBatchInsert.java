import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

/**
 * Change rewriteBatchedStatements=true|false on line 34 to see the performane difference.
 */

public class DemoJdbcBatchInsert{

    public static void printResultSetStringString(String stmtText, Connection connection) {
        int count = 0;
        System.out.println("\n/* Executing query: "+stmtText+"; */");
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(stmtText);
            System.out.println("\tRow#, "+resultSet.getMetaData().getColumnName(1)+", "+resultSet.getMetaData().getColumnName(2));
            while (resultSet.next()) {
                System.out.println("\t"+(++count) + ") " + resultSet.getString(1)+", "+resultSet.getString(2));
            }
            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            System.out.println("Error: "+e);
        }
    }
    public static void main(String[] args){
        Connection connection = null;
        try{
            connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:4000/test?useServerPrepStmts=true&cachePrepStmts=true&rewriteBatchedStatements=false", "root", ""
            );
            System.out.println("Connection established.");
            // Prepare the table in the connection
            String sqlDropTable = "DROP TABLE IF EXISTS test.t1";
            String sqlCreateTable = "CREATE TABLE test.t1 (id int primary key, name char(30))";
            PreparedStatement[] pss = new PreparedStatement[]{
                connection.prepareStatement(sqlDropTable),
                connection.prepareStatement(sqlCreateTable)
            };
            for (PreparedStatement ps:pss){
                ps.executeUpdate();
                ps.close();
            }
            // Batch PS
            /**
             * Try modify rewriteBatchedStatements=true|false to see the difference.
             */
            connection.setAutoCommit(true);
            PreparedStatement insert1_ps = connection.prepareStatement("INSERT INTO t1 VALUES (?, ?)");
            System.out.println(">>> Reuse PS Begin batch insert.");
            long s1 = System.currentTimeMillis();
            for (int i=1;i<20001;i++){
                insert1_ps.setInt(1, i);
                insert1_ps.setString(2, Integer.toString(i));
                insert1_ps.addBatch();
            }
            insert1_ps.executeBatch();
            System.out.println(">>> End repeating update, elapsed: "+Long.toString(System.currentTimeMillis()-s1)+"(ms).");
        }
        catch(SQLException e){
            System.out.println("Error: "+e);
            // Try something
            if(connection != null){
                try{
                    connection.rollback();
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
                    printResultSetStringString("select count(*), max(name) from test.t1", connection);
                    // Turn on autocommit
                    connection.setAutoCommit(true);
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