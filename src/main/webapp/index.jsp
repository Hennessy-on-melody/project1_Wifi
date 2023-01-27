<%@ page import="CloseWifi.CloseWifi" %>
<%@ page import="Database.InsertData" %>
<%@ page import="java.sql.*" %>
<%@ page import="Dto.WIFI" %>
<%@ page import="java.util.*" %>
<%@ page import="Dto.History" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<style>
    tr {
        text-align: center;
        background-color: #00dc01;
        color: white;}

    td {
        text-align: center;
        background-color: white;
        color: black;}

    tr, td {
        border-bottom: 1px solid #999;
        padding: 5px;
    }
</style>
<head>
    <title>와이파이 정보 구하기</title>
    <h1>와이파이 정보 구하기</h1>
</head>
<body>
<script>
    const pos = (e) => {
        e.preventDefault()
        navigator.geolocation.getCurrentPosition((position) => {
            let latitude = position.coords.latitude;
            let longitude = position.coords.longitude;

            document.getElementById("lat").value = latitude
            document.getElementById("lnt").value = longitude
            console.log('latitude', latitude);
            console.log('longitude', longitude);
        })
    }

</script>
<div>
    <span>
        <a href="index.jsp">홈</a>
    </span>
    <span>
        <a href="load-wifi.jsp">Open API 정보 가져오기</a>
    </span>
    <span>
        <a href="History.jsp">위치 히스토리 목록</a>
    </span>

</div>
<div>
    <form method="post">
        <label for="lat">LAT: </label><input id="lat" name="lat" type="number" step="any"/>
        <label for="lnt">LNT: </label><input id="lnt" name="lnt" type="number" step="any"/>
        <button onclick="pos(event)">내 위치 가져오기</button>
        <button type="submit">근처 와이파이 정보 보기</button>
    </form>
    <%
        String st = "";
        List<WIFI> list = new ArrayList<>();
        List<History> historyResult =  new ArrayList<>();
        Integer Id = 1;
//        System.out.println("request" + request.getMethod());
        if (request.getMethod().equals("POST")){
            Connection connection = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            ResultSet historyRs = null;
            String sql = "SELECT * FROM Project1";

            try {
                Class.forName("org.mariadb.jdbc.Driver");
                String url = "jdbc:mariadb://localhost:3306/project1";
                connection = DriverManager.getConnection(url, "projectUser", "project1");
                pstmt = connection.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while (rs.next()){
//                    System.out.println("rs=======: " + rs.getString("LAT"));
                    WIFI wifi = new WIFI(
                            rs.getString("X_SWIFI_MGR_NO"),
                            rs.getString("X_SWIFI_WRDOFC"),
                            rs.getString("X_SWIFI_MAIN_NM"),
                            rs.getString("X_SWIFI_ADRES1"),
                            rs.getString("X_SWIFI_ADRES2"),
                            rs.getString("X_SWIFI_INSTL_FLOOR"),
                            rs.getString("X_SWIFI_INSTL_TY"),
                            rs.getString("X_SWIFI_INSTL_MBY"),
                            rs.getString("X_SWIFI_SVC_SE"),
                            rs.getString("X_SWIFI_CMCWR"),
                            rs.getString("X_SWIFI_CNSTC_YEAR"),
                            rs.getString("X_SWIFI_INOUT_DOOR"),
                            rs.getString("X_SWIFI_REMARS3"),
                            rs.getString("LAT"),
                            rs.getString("LNT"),
                            rs.getString("WORK_DTTM"),
                            CloseWifi.getDistance(
                                    Double.parseDouble(request.getParameter("lat")),
                                    Double.parseDouble(request.getParameter("lnt")),
                                    Double.parseDouble(rs.getString("LAT")),
                                    Double.parseDouble(rs.getString("LNT"))
                            )
                    );
                    System.out.println("DISTANCE===========: " + wifi.getDISTANCE().toString());
//                    System.out.println("WIFI" + wifi.toString());

                    list.add(wifi);
                }
                Collections.sort(list, (Comparator.comparingDouble(WIFI::getDISTANCE)));

                if (list.size() > 0) {
                    System.out.println("쿼리 성공");
//                System.out.println("변경된 로우" + re);
                } else {
                    System.out.println("쿼리 실패");
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace(); //오류를 콘솔에 나타낸다.
            } catch (SQLException e){
                e.printStackTrace();
            } finally {
                try {
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }



    %>
<table>
    <thead>
        <tr>
            <th>거리</th>
            <th>관리번호</th>
            <th>자치구</th>
            <th>와이파이명</th>
            <th>도로명주소</th>
            <th>상세주소</th>
            <th>설치위치(층)</th>
            <th>설치유형</th>
            <th>설치기관</th>
            <th>서비스구분</th>
            <th>망종류</th>
            <th>설치년도</th>
            <th>실내외구분</th>
            <th>WIFI접속환경</th>
            <th>X좌표</th>
            <th>Y좌표</th>
            <th>작업일자</th>
        </tr>
    </thead>
    <tbody>
    <% if (list.size() > 0){ %>

    <% for (int i = 0; i < 20; i++) { %>
    <tr>
        <td>
            <%= list.get(i).getDISTANCE() + "km" %>
        </td>
        <td>
        <%= list.get(i).getX_SWIFI_MGR_NO() %>
        </td>
        <td>
        <%= list.get(i).getX_SWIFI_WRDOFC() %>
        </td>
        <td>
            <%= list.get(i).getX_SWIFI_MAIN_NM() %>
        </td>
        <td>
        <%= list.get(i).getX_SWIFI_ADRES1() %>
        </td>
        <td>
            <%= list.get(i).getX_SWIFI_ADRES2() %>
        </td>
        <td>
            <%= list.get(i).getX_SWIFI_INSTL_FLOOR() %>
        </td>
        <td>
            <%= list.get(i).getX_SWIFI_INSTL_TY() %>
        </td>
        <td>
            <%= list.get(i).getX_SWIFI_INSTL_MBY() %>
        </td>
        <td>
            <%= list.get(i).getX_SWIFI_SVC_SE() %>
        </td>
        <td>
            <%= list.get(i).getX_SWIFI_CMCWR() %>
        </td>
        <td>
            <%= list.get(i).getX_SWIFI_CNSTC_YEAR() %>
        </td>
        <td>
            <%= list.get(i).getX_SWIFI_INOUT_DOOR() %>
        </td>
<%--        <td>--%>
<%--            <%= st %>--%>
<%--        </td>--%>
        <td>
            <%= list.get(i).getX_SWIFI_REMARS3() %>
        </td>
        <td>
            <%= list.get(i).getLAT() %>
        </td>
        <td>
            <%= list.get(i).getLNT() %>
        </td>
        <td>
            <%= list.get(i).getWORK_DTTM() %>
        </td>
    </tr>
        <% } %>
    <% } %>
    </tbody>
</table>

</div>
</body>
</html>