import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DemoJdbcExecuteUpdate{
    public static void main(String[] args){
        Connection connection = null;
        try{
            connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:4000/test?useServerPrepStmts=true&cachePrepStmts=true&rewriteBatchedStatements=true", "root", ""
            );
            System.out.println("Connection established");
            // Do something in the connection
            Statement statement = connection.createStatement();
            statement.executeUpdate("DROP TABLE IF EXISTS t1");
            statement.executeUpdate("CREATE TABLE t1 (id int PRIMARY KEY, name char(4))");
            System.out.println("Table test.t1 created");
            int rowCount = 0;
            rowCount = statement.executeUpdate("INSERT INTO t1 VALUES(1, 'ABCD')");
            System.out.println(rowCount+" row inserted into table test.t1");
            rowCount = statement.executeUpdate("INSERT INTO t1 VALUES(2, 'EFGH')");
            System.out.println(rowCount+" row inserted into table test.t1");
            rowCount = statement.executeUpdate("INSERT INTO t1 VALUES(3, 'IJKL'), (4, 'MNOP')");
            System.out.println(rowCount+" row inserted into table test.t1");
            statement.close();
            // Finish
        }
        catch(SQLException e){
            System.out.println("Error: "+e);
        }
        finally{
            if(connection != null){
                try{
                    connection.close();
                    System.out.println("Connection closed");
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