import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class DemoJdbcPreparedStatementOnlineDDL{

    static int I;
    static String MAIN_STREAM_TASK = "INSERT INTO test.target_table (id, name1) SELECT NULL, name FROM test.seed";


    public static void printResultSetLong(String stmtText, Connection connection) {
        int count = 0;
        System.out.println("\n/* Executing query: "+stmtText+"; */");
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(stmtText);
            System.out.println("\tRow#, "+resultSet.getMetaData().getColumnName(1));
            while (resultSet.next()) {
                System.out.println("\t"+(++count) + ") " + resultSet.getLong(1));
            }
            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            System.out.println("Error: "+e);
        }
    }

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
    public static void main(String[] args) throws InterruptedException{
        Connection connection = null;
        try{
            connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:4000/test?useServerPrepStmts=true&cachePrepStmts=true&rewriteBatchedStatements=true", "root", ""
            );
            System.out.println("Connection established.");
            // Do something in the connection
            String sqlDropTable = "DROP TABLE IF EXISTS test.target_table";
            String sqlCreateTable = "CREATE TABLE test.target_table(id bigint PRIMARY KEY AUTO_RANDOM, name1 char(20))";
            String sqlDropSeedTable = "DROP TABLE IF EXISTS test.seed";
            String sqlCreateSeedTable = "CREATE TABLE test.seed(name char(20))";
            String sqlInsertIntoSeed = "insert into test.seed (name) values ('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL')";
            PreparedStatement[] pss = new PreparedStatement[]{
                connection.prepareStatement(sqlDropTable),
                connection.prepareStatement(sqlCreateTable),
                connection.prepareStatement(sqlDropSeedTable),
                connection.prepareStatement(sqlCreateSeedTable),
                connection.prepareStatement(sqlInsertIntoSeed)
            };
            for (PreparedStatement ps:pss){
                System.out.println("preparing");
                ps.executeUpdate();
                ps.close();
            }
            // Populate Seed
            connection.setAutoCommit(false);
            String sqlDoubleSeed = "insert into test.seed select * from test.seed";
            PreparedStatement psDoubleSeed = connection.prepareStatement(sqlDoubleSeed);
            for (int i=0;i<6;i++){
                System.out.println("populating");
                psDoubleSeed.executeUpdate();
                connection.commit();
            }
            printResultSetLong("select count(*) as \"|320|\" from test.seed", connection);
            printResultSetStringString("DESC test.target_table", connection);
            Thread.sleep(5000);
            // Workload
            connection.commit();
            PreparedStatement psMainInsert= connection.prepareStatement(MAIN_STREAM_TASK);
            for(int i=0;i<200;i++){
                I = i;
                System.out.println("Main stream workload ..."+i);
                psMainInsert.executeUpdate();
                psMainInsert.executeUpdate();
                psMainInsert.executeUpdate();
                connection.commit();
                System.out.println("Main stream workload commit ...");
                printResultSetStringString("SELECT name1 as \"|NAME1|\", count(*) as \"|BEFORE-DDL: 192000|\" FROM test.target_table GROUP BY name1 ORDER BY 1", connection);
            }
        }
        catch(SQLException e){
            System.out.println("Main stream error.");
            System.out.println("Error: "+e);
            System.out.println("SQLState: "+e.getSQLState());
            System.out.println("ErrorCode: "+e.getErrorCode());
            e.printStackTrace();
            // Try something
            if(connection != null){
                try{
                    if (e.getErrorCode()==8028){
                        System.out.println("8028 encountered, backoff...");
                        Thread.sleep(5000);
                        connection.rollback();
                        PreparedStatement psMainInsert= connection.prepareStatement(MAIN_STREAM_TASK);
                        for(int i=I;i<200;i++){
                            I = i;
                            System.out.println("Main stream workload ..."+i);
                            psMainInsert.executeUpdate();
                            psMainInsert.executeUpdate();
                            psMainInsert.executeUpdate();
                            connection.commit();
                            System.out.println("Main stream workload commit ...");
                            printResultSetStringString("SELECT name1 as \"|NAME1|\", count(*) as \"|BEFORE-DDL: 192000|\" FROM test.target_table GROUP BY name1 ORDER BY 1", connection);
                        }
                    }
                    //connection.rollback();
                    //System.out.println("Transaction rolled back.");
                    //System.out.println("I: "+I);
                }
                catch(SQLException e2){
                    System.out.println("TX Rollback error.");
                    System.out.println("Error: "+e);
                    System.out.println("SQLState: "+e.getSQLState());
                    System.out.println("ErrorCode: "+e.getErrorCode());
                    e.printStackTrace();
                }
            }
        }
        finally{
            if(connection != null){
                try{
                    // Check the battle field
                    // printResultSetStringString("select * from test.t1", connection);
                    // Turn on autocommit
                    System.out.println("I: "+I);
                    connection.setAutoCommit(true);
                    System.out.println("Turn on autocommit.");
                    connection.close();
                    System.out.println("Connection closed.");
                }
                catch(SQLException e){
                    System.out.println("Disconnecting error.");
                    System.out.println("Error: "+e);
                    System.out.println("SQLState: "+e.getSQLState());
                    System.out.println("ErrorCode: "+e.getErrorCode());
                    e.printStackTrace();
                }
            }
            else{
                System.out.println("Already disconnected.");
            }
        }
    }
}