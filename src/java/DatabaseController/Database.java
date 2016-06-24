/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DatabaseController;


import java.sql.*;

/**
 *
 * @author Leader
 */
public class Database {
    public static Connection getConnection() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll?useUnicode=true&characerEncoding=UTF-&autoReconnect=true","root","12345");
        
        return con;
    }
}
