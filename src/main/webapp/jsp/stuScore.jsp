<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select substr(s.sno,1,1) grade, substr(s.sno,2,2) class, substr(s.sno,4,2) classnum, s.sname, e.ekor, e.emath, e.eeng, e.ehist,");
	sb.append(" sum(ekor+emath+eeng+ehist) sum, sum(ekor+emath+eeng+ehist)/4 avg,");
	sb.append(" rank() over (order by sum(ekor+emath+eeng+ehist) desc) rank");
	sb.append(" from student_tbl_03 s, exam_tbl_03 e");
	sb.append(" where s.sno=e.sno");
	sb.append(" group by substr(s.sno,1,1), substr(s.sno,2,2), substr(s.sno,4,2), s.sname, e.ekor, e.emath, e.eeng, e.ehist");
	sb.append(" union all");
	sb.append(" select nvl(to_char(null),1), to_char(null), to_char(null), to_char(null), sum(ekor), sum(emath), sum(eeng), sum(ehist),");
	sb.append(" sum(ekor+emath+eeng+ehist), sum(ekor+emath+eeng+ehist)/4, to_number(null)");
	sb.append(" from exam_tbl_03");
	sb.append(" union all");
	sb.append(" select to_char(null), to_char(null), to_char(null), to_char(null), avg(ekor), avg(emath), avg(eeng), avg(ehist),");
	sb.append(" avg(ekor+emath+eeng+ehist), avg(ekor+emath+eeng+ehist)/4, to_number(null)");
	sb.append(" from exam_tbl_03");

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
		<h2>학생성적</h2>
		
		<table>
			<thead>
				<tr>
					<th>학년</th>
					<th>반</th>
					<th>번호</th>
					<th>이름</th>
					<th>국어</th>
					<th>수학</th>
					<th>영어</th>
					<th>역사</th>
					<th>합계</th>
					<th>평균</th>
					<th>순위</th>
				</tr>
			</thead>
			<tbody>
			<%
				while(rs.next()) {
					if(rs.getString("class")!=null) {
			%>
				<tr>
					<td><%= rs.getString("grade") %></td>
					<td><%= rs.getString("class") %></td>
					<td><%= rs.getString("classnum") %></td>
					<td><%= rs.getString("sname") %></td>
					<td><%= rs.getString("ekor") %></td>
					<td><%= rs.getString("emath") %></td>
					<td><%= rs.getString("eeng") %></td>
					<td><%= rs.getString("ehist") %></td>
					<td><%= rs.getString("sum") %></td>
					<td><%= rs.getString("avg") %></td>
					<td><%= rs.getString("rank") %></td>
					
				</tr>
			<%
					} else if(rs.getInt("grade")==1) {
			%>
				<tr>
					<td colspan="4">총합계</td>
					<td><%= rs.getString("ekor") %></td>
					<td><%= rs.getString("emath") %></td>
					<td><%= rs.getString("eeng") %></td>
					<td><%= rs.getString("ehist") %></td>
					<td><%= rs.getString("sum") %></td>
					<td><%= rs.getString("avg") %></td>
				</tr>
			<%						
					} else {
			%>
				<tr>
					<td colspan="4">총평균</td>
					<td><%= rs.getInt("ekor") %></td>
					<td><%= rs.getInt("emath") %></td>
					<td><%= rs.getInt("eeng") %></td>
					<td><%= rs.getInt("ehist") %></td>
					<td><%= rs.getInt("sum") %></td>
					<td><%= rs.getInt("avg") %></td>
				</tr>		
			<%						
					}
				}
			%>
			</tbody>
		</table>
	</section>

	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>