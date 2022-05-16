import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class DemoJdbcPreparedStatement{

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
                "jdbc:mysql://localhost:4000/test?useServerPrepStmts=true&cachePrepStmts=false&rewriteBatchedStatements=true", "root", ""
            );
            System.out.println("Connection established.");
            // Do something in the connection
            String offAutoCommit = "SET @@autocommit = 0";
            String sqlDropTable = "DROP TABLE IF EXISTS test.t1";
            String sqlCreateTable = "CREATE TABLE test.t1 (id int primary key, name char(30))";
            String sqlInsertIntoTable = "INSERT INTO test.t1 (id, name) VALUES (?, ?)";
            PreparedStatement[] pss = new PreparedStatement[]{
                connection.prepareStatement(offAutoCommit),
                connection.prepareStatement(sqlDropTable),
                connection.prepareStatement(sqlCreateTable),
                connection.prepareStatement(sqlInsertIntoTable)
            };
            pss[3].setInt(1, 10);
            pss[3].setString(2, "ABC");
            for (PreparedStatement ps:pss){
                ps.executeUpdate();
                ps.close();
            }
            // Reuse PS
            connection.setAutoCommit(true);
            PreparedStatement update1_ps = connection.prepareStatement("UPDATE test.t1 SET name = ? WHERE id = 1");
            System.out.println(">>> Reuse PS Begin repeating update.");
            long s1 = System.currentTimeMillis();
            for (int i=0;i<20000;i++){
                update1_ps.setString(1, Integer.toString(i));
                update1_ps.executeUpdate();
            }
            System.out.println(">>> End repeating update, elapsed: "+Long.toString(System.currentTimeMillis()-s1)+"(ms).");
            // Non-Reuse PS
            connection.setAutoCommit(true);
            /**
             * Client side caching prepared statment, cache hit for prepareStatement and close.
             * Try set cachePrepStmts=false|true to see the difference on elapsed time.
             */
            PreparedStatement update2_ps = null;
            System.out.println(">>> Non-Reuse PS Begin repeating update.");
            long s2 = System.currentTimeMillis();
            for (int i=0;i<20000;i++){
                update2_ps = connection.prepareStatement("UPDATE test.t1 SET name = ? WHERE id = 1");
                update2_ps.setString(1, Integer.toString(i));
                update2_ps.executeUpdate();
                update2_ps.close();
            }
            System.out.println(">>> End repeating update, elapsed: "+Long.toString(System.currentTimeMillis()-s2)+"(ms).");
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
                    printResultSetStringString("select * from test.t1", connection);
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