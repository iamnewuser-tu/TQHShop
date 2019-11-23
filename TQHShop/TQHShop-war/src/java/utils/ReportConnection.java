package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class ReportConnection {

    public Connection connect() {
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=TQHShop", "sa", "123");
            System.out.println("success");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }

    public static void main(String[] args) {
        ReportConnection con = new ReportConnection();
        con.connect();
    }

}
