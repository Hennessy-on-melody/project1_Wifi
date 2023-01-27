package Database;

import Dto.WIFI;

import java.sql.*;

public class InsertData {

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

    public void insertData(WIFI wifi) {
        InsertData.jdbcConnection();
        String sql = "INSERT INTO Project1(X_SWIFI_MGR_NO, X_SWIFI_WRDOFC, X_SWIFI_MAIN_NM, X_SWIFI_ADRES1, X_SWIFI_ADRES2, X_SWIFI_INSTL_FLOOR, X_SWIFI_INSTL_TY, X_SWIFI_INSTL_MBY, X_SWIFI_SVC_SE, X_SWIFI_CMCWR, X_SWIFI_CNSTC_YEAR, X_SWIFI_INOUT_DOOR, X_SWIFI_REMARS3, LAT, LNT, WORK_DTTM) " +
                "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, wifi.getX_SWIFI_MGR_NO());
            pstmt.setString(2, wifi.getX_SWIFI_WRDOFC());
            pstmt.setString(3, wifi.getX_SWIFI_MAIN_NM());
            pstmt.setString(4, wifi.getX_SWIFI_ADRES1());
            pstmt.setString(5, wifi.getX_SWIFI_ADRES2());
            pstmt.setString(6, wifi.getX_SWIFI_INSTL_FLOOR());
            pstmt.setString(7, wifi.getX_SWIFI_INSTL_TY());
            pstmt.setString(8, wifi.getX_SWIFI_INSTL_MBY());
            pstmt.setString(9, wifi.getX_SWIFI_SVC_SE());
            pstmt.setString(10, wifi.getX_SWIFI_CMCWR());
            pstmt.setString(11, wifi.getX_SWIFI_CNSTC_YEAR());
            pstmt.setString(12, wifi.getX_SWIFI_INOUT_DOOR());
            pstmt.setString(13, wifi.getX_SWIFI_REMARS3());
            pstmt.setString(14, wifi.getLAT());
            pstmt.setString(15, wifi.getLNT());
            pstmt.setString(16, wifi.getWORK_DTTM());
            int count;
            count = pstmt.executeUpdate();
//            System.out.println(count);
        } catch (SQLException e){
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null){
                    pstmt.close();
                }
                if (conn != null){
                    conn.close();
                }
            } catch (SQLException e){
                e.printStackTrace();
            }
        }
    }
}
