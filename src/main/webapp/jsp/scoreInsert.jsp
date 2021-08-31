<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sql = "insert into exam_tbl_03 values (?,?,?,?,?)";
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	// insert into exam_tbl_03 values (?,?,?,?,?)
	
	pstmt.setString(1, request.getParameter("sno"));
	// insert into exam_tbl_03 values ("10103",?,?,?,?)
	pstmt.setInt(2, Integer.parseInt(request.getParameter("ekor")));
	// insert into exam_tbl_03 values ("10103",99,?,?,?)
	pstmt.setInt(3, Integer.parseInt(request.getParameter("emath")));
	// insert into exam_tbl_03 values ("10103",99,98,?,?)
	pstmt.setInt(4, Integer.parseInt(request.getParameter("eeng")));
	// insert into exam_tbl_03 values ("10103",99,98,88,?)
	pstmt.setInt(5, Integer.parseInt(request.getParameter("ehist")));
	// insert into exam_tbl_03 values ("10103",99,98,88,100)
	
	pstmt.executeUpdate();
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:forward page="inputScore.jsp"></jsp:forward>
</body>
</html>