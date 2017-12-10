<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%

	request.setCharacterEncoding("euc-kr");

	String d_id= request.getParameter("d_id");
	String quantity=request.getParameter("quantity");
	String dong=request.getParameter("dong");
	String address=request.getParameter("address");
	String phone=request.getParameter("phone");



	//db에 저장하기
	int n=0;

	String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
	String user = "sys as sysdba";
	String pass = "DBLab012345";
	Connection conn = null;
	String  sql = "update customer Set dong=?, address=?, phone=? where c_id=832";
	String query = null;
	PreparedStatement pstmt=null;
	ResultSet rs = null;
	
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

	try{

	//	con = DBConnection.getCon();

		pstmt = conn.prepareStatement(sql);

	//	pstmt.setString(1, quantity);

		pstmt.setString(1, dong);

		pstmt.setString(2, address);

		pstmt.setString(3, phone);
	//	pstmt.setString(4,d_id);
	
		n = pstmt.executeUpdate();
		
		pstmt.close();
		conn.commit();
		conn.setAutoCommit(true);
		conn.close();
		
	} catch(Exception e) {
	
		System.err.println("sql error = " + e.getMessage());
	}

%>



<script type="text/javascript">

	if(<%=n%>>0 ){

		alert("수정되었습니다.");

		location.href="sample.jsp";

	}else{

		alert("수정 실패");

		history.go(-1);

	}

</script>

</body>
</html>