<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("euc-kr");
 
      String item_sn = request.getParameter("item");
      String quantity = request.getParameter("Quantity");
      String[] day = request.getParameterValues("Day");
      int nday=0;
      for(String val: day)
	{
		nday += Integer.parseInt(val);
	}

	Timestamp register = new Timestamp(System.currentTimeMillis());

	System.out.println(item_sn);

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String id = (String) session.getAttribute("sessionID");
	String Gu_CUS = "";
	String Dong_CUS = "";
	int Rid = 0;
	// Connection/PreparedStatement/ResultSet ==> interface
	String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
	String user = "kdhong";
	String pass = "kdhong";

	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);

	try {
		String sql0 = "select ADDRESS_GU, ADDRESS_DONG from CUSTOMER where C_ID = (select C_ID from customer where ID=?)";
		pstmt = conn.prepareStatement(sql0);
		pstmt.setString(1, id);
		pstmt.executeUpdate();

		rs = pstmt.executeQuery();
		while (rs.next()) {
			Gu_CUS = rs.getString("ADDRESS_GU");
			Dong_CUS = rs.getString("ADDRESS_DONG");
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException sqle) {
			}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			}

	}

	try {
		String sql1 = "select R_ID from ROUNDSMAN where DONG=? and GU=?";
		pstmt = conn.prepareStatement(sql1);
		pstmt.setString(1, Dong_CUS);
		pstmt.setString(2, Gu_CUS);
		Rid = pstmt.executeUpdate();

		rs = pstmt.executeQuery();
		while (rs.next()) {
			Rid = rs.getInt("R_ID");
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException sqle) {
			}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			}

	}

	try {
		String sql2 = "insert into DELIVERY(C_ID, R_ID, SERIAL_NUMBER, D_DAY, QUANTITY, START_DATE) values((select C_ID from customer where ID=?), ?, (select SERIAL_NUMBER from ITEM where NAME=?),?,?,?)";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, id);
		pstmt.setInt(2, Rid);
		pstmt.setString(3, item_sn);
		pstmt.setInt(4, nday);
		pstmt.setInt(5, Integer.parseInt(quantity));
		pstmt.setTimestamp(6, register);

		pstmt.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {

		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException sqle) {
			}
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="./customerm.jsp"></jsp:include>
</body>
</html>