<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select sno, sname, substr(sno,1,1) grade, substr(sno,2,2) class, substr(sno,4,2) classnum,");
	sb.append(" case when sgender='M' then '남' else '여' end sgender, sphone, saddress");
	sb.append(" from student_tbl_03");
	
	String sql = sb.toString();
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>

	<section id="section">
		<h2>학생목록</h2>
		
		<table>
			<thead>
				<tr>
					<th>학번</th>
					<th>이름</th>
					<th>학년</th>
					<th>반</th>
					<th>번호</th>
					<th>성별</th>
					<th>전화번호</th>
					<th>주소</th>
				</tr>
			</thead>
			<tbody>
			<%
				while(rs.next()) {
			%>
				<tr>
					<td><%= rs.getString("sno") %></td>
					<td><%= rs.getString("sname") %></td>
					<td><%= rs.getString("grade") %></td>
					<td><%= rs.getString("class") %></td>
					<td><%= rs.getString("classnum") %></td>
					<td><%= rs.getString("sgender") %></td>
					<td><%= rs.getString("sphone") %></td>
					<td><%= rs.getString("saddress") %></td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>
	</section>

	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>