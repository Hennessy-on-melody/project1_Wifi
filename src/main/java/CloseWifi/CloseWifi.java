package CloseWifi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class CloseWifi {
    public static void jdbcConnection(){
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e){
            e.printStackTrace();
        }
    }

    public Connection getConnection(){
        Connection conn = null;

        try {
            conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/project1", "projectUser", "project1");
        } catch (SQLException e){
            e.printStackTrace();
        }
        return conn;
    }

    public static double getDistance(double lat1, double lnt1, double lat2, double lnt2){
        double dLat = Math.toRadians(lat2 - lat1);
        double dLnt = Math.toRadians(lnt2 - lnt1);

        double a = Math.sin(dLat/2)* Math.sin(dLat/2)+ Math.cos(Math.toRadians(lat1))* Math.cos(Math.toRadians(lat2))* Math.sin(dLnt/2)* Math.sin(dLnt/2);
        System.out.println(a);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        System.out.println(c);
        double d = 6400 * c / 100;
        double D = Math.round(d * 1000) / 1000.0;
        return D;
    }

    public static void main(String[] args) {
        double distance = CloseWifi.getDistance(137.30495, 59.30394, 149.49586, 78.39857);
        System.out.println("===============" + distance);
    }
}
