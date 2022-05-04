import java.sql.Connection;
import java.sql.DriverManager;

public class DemoJdbcConnection{
    public static void main(String[] args){
        Connection connection = null;
        try{
            // Connect to TiDB server instance directly
            connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:4000/test?cachePrepStmts=true&useServerPrepStmts=true&cachePrepStmts=true&rewriteBatchedStatements=true", "root", ""
            );
            System.out.println("Connection established");
        }
        catch(Exception e){
            System.out.println("Error: "+e.toString());
        }
        finally{
            if(connection != null){
                try{
                    // Release the resources in cascade
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