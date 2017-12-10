<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	
	String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
	String user = "sys as sysdba";
	String pass = "DBLab012345";
	Connection conn = null;
	String sql = null;

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("드라이버 검색 성공!");
	}catch(ClassNotFoundException e) {
		System.err.println("error = " + e.getMessage());
		System.exit(1);
	}

	try{
		conn = DriverManager.getConnection(url,user,pass);
	//	return conn;
		
	}catch(SQLException e) {
		System.err.println("sql error = " + e.getMessage());
		System.exit(1);
//		return null;
	}

	PreparedStatement pstmt = null;
	String id = request.getParameter("id");

	int n=0;

	try{

//		con = DBConnection.getCon();

		sql="delete from delivery where d_id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);

		n = pstmt.executeUpdate();

		pstmt.close();
		conn.commit();
		conn.setAutoCommit(true);
		conn.close();
	
	} catch(Exception e) {

		System.err.println("sql error = " + e.getMessage());
	}
	response.sendRedirect("sample.jsp");

%>


</body>
</html>