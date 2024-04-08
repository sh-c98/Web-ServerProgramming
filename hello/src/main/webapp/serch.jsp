<%@page import="org.apache.jasper.tagplugins.jstl.core.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>명함 검색</title>
</head>
<body>



<h1>명함 검색</h1>
<form action="search.jsp" method="post">
	<input type="text" name="keyword" placeholder="검색어 입력">
	<input type="submit" value="검색">
</form>

<%
// OracleXE 연결

Connection conn = null;
ResultSet rs = null;
Statement stmt = null;

String url = "jdbc:oracle:thin:@localhost:1521/xe";
String user = "system";
String password = "1234";

Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url, user, password);

//검색어 처리
String keyword = request.getParameter("keyword");

//SQL 쿼리 작성
String sql = "SELECT * FROM namecard";
if (keyword != null && !keyword.isEmpty()) {
sql += " WHERE name LIKE '%" +keyword+ "%' OR telno LIKE '%" +keyword+ "%' OR mail LIKE '%" +keyword+ "%'";
}

//Statement 생성 및 실행

stmt = conn.createStatement();
StringBuffer sb = new StringBuffer();
sb.append(sql);
rs = stmt.executeQuery(sb.toString());

//검색 결과 출력
%>
<table border="1">
<tr>
 <th>순번</th>
 <th>이름</th>
 <th>폰번호</th>
 <th>메일</th>
</tr>

<%
int count = 1;
while(rs.next()) {
	%>
	<tr>
	 <td><%= count++ %></td>
	 <td><%= rs.getString("name") %></td>
	 <td><%= rs.getString("telno") %></td>
	 <td><%= rs.getString("mail") %></td>
	</tr>
	<%
}
rs.close();
stmt.close();
conn.close();
%>


</table>
</body>
</html>
