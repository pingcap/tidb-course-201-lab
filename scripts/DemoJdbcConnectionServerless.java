import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.sql.*;

public class DemoJdbcConnectionServerless {
    public static void main(String[] args) {
        Connection connection = null;
        String username = args[0];
        String password = args[1];
        String connection_string = "jdbc:mysql://gateway01.ap-southeast-1.prod.aws.tidbcloud.com:4000/test?user=" + 
                username + "&password=" + password + "&sslMode=VERIFY_IDENTITY&enabledTLSProtocols=TLSv1.2,TLSv1.3";

        try {
            // Connect to TiDB server instance directly
            connection = DriverManager.getConnection(
                    connection_string, username, password);
            System.out.println("Connection established.");
        } catch (Exception e) {
            System.out.println("Error: " + e);
        } finally {
            if (connection != null) {
                try {
                    // Release the resources in cascade
                    connection.close();
                    System.out.println("Connection closed.");
                } catch (SQLException e) {
                    System.out.println("Error disconnecting: " + e.toString());
                }
            } else {
                System.out.println("Already disconnected.");
            }
        }
    }
}