<%@ page import="com.squareup.okhttp.OkHttpClient" %>
<%@ page import="com.squareup.okhttp.Request" %>
<%@ page import="com.squareup.okhttp.Response" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="Dto.WIFI" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="Database.InsertData" %>
<%--

Created by IntelliJ IDEA.
User: hennessy_on_melody
Date: 2022/12/31
Time: 4:06 PM
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<style>
    h1 {text-align: center}
</style>
<head>
    <title>Open API~~</title>
</head>
<body>
<%

        //1페이지부터 19000페이지 까지 반복(한 페이지당 1000개 가능)
    OkHttpClient client = new OkHttpClient();
    Request req = new Request.Builder().url("http://openapi.seoul.go.kr:8088/5a6e526a5468656e39367259416c58/json/TbPublicWifiInfo/1/1/").get().build();
    Response res = client.newCall(req).execute();
    String json = res.body().string();
    JsonObject obj = new Gson().fromJson(json, JsonObject.class);
    JsonObject obj2 = obj.get("TbPublicWifiInfo").getAsJsonObject();
    System.out.println(obj);
    int total = obj2.get("list_total_count").getAsInt();

    for (int i = 1; i <= total; i++) {
        req = new Request.Builder().url("http://openapi.seoul.go.kr:8088/5a6e526a5468656e39367259416c58/json/TbPublicWifiInfo/" + i + "/" + i + "/").get().build();
        res = client.newCall(req).execute();
        json = res.body().string();
        Gson gson = new Gson();
        obj = new Gson().fromJson(json, JsonObject.class);
        obj2 = obj.get("TbPublicWifiInfo").getAsJsonObject();
        JsonArray arr = obj2.get("row").getAsJsonArray();
        JsonObject tmp = arr.get(0).getAsJsonObject();
        WIFI wifi = gson.fromJson(tmp, WIFI.class);
        InsertData insert = new InsertData();
        insert.insertData(wifi);
    }

    %>

<h1><%=total%>개의 데이터가 저장되었습니다.</h1>
</body>
</html>
