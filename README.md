<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<nav>
		<ul>
			<li><a href="input.jsp">명함입력</a></li>
			<li><a href="serch.jsp">명함검색</a></li>
		</ul>
	</nav>

	<h1>손희창</h1>
	<h2>폰번호 : 010-XXXX-XXXX</h2>




</body>
</html>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div align="center"></div>
	<table border="1" width="550" height="300">
		<tr align="center">
			<td>이름</td>
			<td><input type = "text" name = "txtName" size = "10"></td>
		</tr>	
		<tr align="center">
			<td>관계</td>
			<td><input type = "text" name = "txtRelationship" size = "10"></td>
		</tr>	
		<tr align="center">
			<td>폰번호</td>
			<td><input type = "text" name = "txtPhone" size = "15"></td>
		</tr>			
		<tr align="center">
			<td>메일</td>
			<td><input type = "text" name = "txtMail" size = "30"></td>
		</tr>	
		<tr align="center">
			<td>주소</td>
			<td><input type = "text" name = "txtAdress" size = "50"></td>
		</tr>	
		<tr>
			<td colspan="2">
				<button type="submit">저장</button>
				<button type="reset">취소</button>
			</td>
		</tr>	
	</table>


}<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>명함 검색</title>
</head>
<body>
<h1>명함 검색</h1>
<from action="search.jsp" method="post">
	<input type="text" name="keyword" placeholder="검색어 입력">
	<input type="submit" value="검색">
</from>

<%
//oraclexe 연결

Connection conn = null;

String url = "jdbc:oracle:thin:@localhost:1521/xe";
String user = "system";
String password = "1234";

Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url, user, password);

//검색어 처리
String keyword = request.getParameter("keyword");

//SQL 쿼리 작성
String sql = "SELECT * From namecard";
if(keyword != null && !keyword.isEmpty()){
	sql+= "WHERE name LIKE '%" + keyword + "%' OR telno LIKE '%" +
			keyword + "%' OR mail LIKE '%" + keyword + "%'";
}

// statement 생성 및 실행
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
// 검사 결과 출력
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
while (rs.next()){
%>
<tr>
	<td><%= count++ %></td>
	<td><%= rs.getString("name") %></td>
	<td><%= rs.getString("telno")%></td>
	<td><%= rs.getString("mail")%></td>
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
