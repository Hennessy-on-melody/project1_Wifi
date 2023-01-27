<%@ page import="java.util.List" %>
<%@ page import="Dto.WIFI" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Dto.History" %>
<%@ page import="java.time.LocalDate" %><%--
  Created by IntelliJ IDEA.
  User: hennessy_on_melody
  Date: 2023/01/06
  Time: 2:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이정보구하기 - 위치 히스토리 목록</title>
    <h1>위치 히스토리 목록</h1>
</head>
<body>

<%
    List<History> historyResult =
%>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>조회일자</th>
        <th>비고</th>
    </tr>

    <tbody>
<% if (historyResult.size() > 0){ %>
<% for (int i = 0; i < result.size(); i++) { %>
<tr>
    <td>
        <%= result.get(i).getId() %>
    </td>
    <td>
        <%= result.get(i).getX() %>
    </td>
    <td>
        <%= result.get(i).getY() %>
    </td>
    <td>
        <%= result.get(i).getTime() %>
    </td>
</tr>
<%
    }
}
%>
</tbody>
    </thead>
</table>

</body>
</html>
