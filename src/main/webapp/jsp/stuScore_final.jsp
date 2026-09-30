<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// DB: 성적 원본 + 순위
	String sql = "select s.sno, s.sname, e.ekor, e.emath, e.eeng, e.ehist,"
			   + " rank() over (order by e.ekor + e.emath + e.eeng + e.ehist desc) rank"
			   + " from student_tbl_03 s, exam_tbl_03 e"
			   + " where s.sno = e.sno"
			   + " order by s.sno";

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생성적</title>
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
					<th>학년</th><th>반</th><th>번호</th><th>이름</th>
					<th>국어</th><th>수학</th><th>영어</th><th>역사</th>
					<th>합계</th><th>평균</th><th>순위</th>
				</tr>
			</thead>
			<tbody>
			<%
				// 세로 합계용 변수
				int totKor = 0, totMath = 0, totEng = 0, totHist = 0, totSum = 0;
				int cnt = 0;

				while (rs.next()) {
					// 학번 분리 (10101 → 1 / 01 / 01)
					String sno = rs.getString("sno");
					String grade    = sno.substring(0, 1);
					String ban      = sno.substring(1, 3);
					String classnum = sno.substring(3, 5);

					int kor  = rs.getInt("ekor");
					int math = rs.getInt("emath");
					int eng  = rs.getInt("eeng");
					int hist = rs.getInt("ehist");

					// 학생별 합계, 평균
					int sum = kor + math + eng + hist;
					double avg = sum / 4.0;

					// 세로 합계 누적
					totKor  += kor;
					totMath += math;
					totEng  += eng;
					totHist += hist;
					totSum  += sum;
					cnt++;
			%>
				<tr>
					<td><%= grade %></td>
					<td><%= ban %></td>
					<td><%= classnum %></td>
					<td><%= rs.getString("sname") %></td>
					<td><%= kor %></td>
					<td><%= math %></td>
					<td><%= eng %></td>
					<td><%= hist %></td>
					<td><%= sum %></td>
					<td><%= avg %></td>
					<td><%= rs.getInt("rank") %></td>
				</tr>
			<%
				}
			%>
				<tr>
					<td colspan="4">총합계</td>
					<td><%= totKor %></td>
					<td><%= totMath %></td>
					<td><%= totEng %></td>
					<td><%= totHist %></td>
					<td><%= totSum %></td>
					<td><%= totSum / 4.0 %></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="4">총평균</td>
					<td><%= totKor / cnt %></td>
					<td><%= totMath / cnt %></td>
					<td><%= totEng / cnt %></td>
					<td><%= totHist / cnt %></td>
					<td><%= totSum / cnt %></td>
					<td><%= totSum / 4 / cnt %></td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</section>

	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>
<%
	rs.close();
	pstmt.close();
	conn.close();
%>
