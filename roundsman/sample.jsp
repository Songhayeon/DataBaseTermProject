<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>직원</title>
</head>
<body>
	<%  int row=1;%>
	<% 
	String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
	String user = "sys as sysdba";
	String pass = "DBLab012345";
	Connection conn = null;
	String sql = null;
	String query = null;

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
		try {
//			conn = DBConnection.getCon();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from roundsman");
			
	%>
	직원의 정보</br>
	<table width="550"border="1" >
		<tr>
		<td>e_id</td>
		<td>name</td>
		<td>phone</td>
		<td>dong</td>
		<td>address</td>
		</tr>
	<%
		
		while (rs.next()) {
			int e_id = rs.getInt(1);
			int phone = rs.getInt("phone");
			String name = rs.getString("name");
			String dong = rs.getString("dong");
			String address = rs.getString("address");
		%>
		<tr>
		<td><%=e_id%></td>
		<td><%=name%></td>
		<td><%=phone%></td>
		<td><%=dong%></td>
		<td><%=address%></td>
		</tr>
		<%
		}	%>
		</table>
		
		</br></br>직원의 전체 배달목록 </br>
		<%ResultSet rs2 = stmt.executeQuery("select i.name,i.price,i.data, c.name, c.phone, c.cu,c.dong,c.address,d.quantity, d.d_day, d.start_date, d.d_id from delivery d,item i, customer c, roundsman r where d.e_id=r.e_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number "); %>
		<table border="1">
		<tr>
		<td>item</td>
		<td>price</td>
		<td>i_data</td>
		<td>customer</td>
		<td>c_phone</td>
		<td>c_cu</td>
		<td>c_dong</td>
		<td>c_address</td>
		<td>quantity</td>
		<td>d_day</td>
		<td>start_date</td>
		<td>수정</td>
		<td>삭제</td>
		</tr>
		<%
		while (rs2.next()) {
			
			String name = rs2.getString(1);
			int price = rs2.getInt(2);
			int i_date = rs2.getInt(3);
			String customer = rs2.getString(4);
			int phone = rs2.getInt(5);
			String cu = rs2.getString(6);
			String dong = rs2.getString(7);
			String address = rs2.getString(8);
			int quantity = rs2.getInt(9);
			int d_day = rs2.getInt(10);
			Date start_date = rs2.getDate(11);
			int d_id = rs2.getInt(12);
		%>
		<tr>
		<td><%=name%></td>
		<td><%=price%></td>
		<td><%=i_date%></td>
		<td><%=customer%></td>
		<td><%=phone%></td>
		<td><%=cu%></td>
		<td><%=dong%></td>
		<td><%=address%></td>
		<td><%=quantity%></td>
		<td><%=d_day%></td>
		<td><%=start_date%></td>
		<td><a href="update.jsp?id=<%=d_id %>">수정</a></td>
		<td><a href="delete.jsp?id=<%=d_id %>">삭제</a></td>
		</tr>
		<%
		}	%>
		</table>
		
		</br></br>검색</br>
		<form name='frm2'>
			<tr>
			<select name='search'>
				<option value='' selected>조회대상</option>
				<option value='i.name'>아이템</option>
				<option value='c.name'>고객이름</option>
				<option value='c.dong'>동</option>
			</select>
			</tr>
			<tr>
			<td>검색할거</td>
			<td><input type="text" name="search_target"/></td>
			<td><button>조회</button></td>
			</tr>
		</form>
		<%
		String category = request.getParameter("search");
		String target =request.getParameter("search_target");
		
		if(category.equals("i.name"))
		{
			query = "select i.name,i.price,i.data, c.name, c.phone, c.cu,c.dong,c.address,d.quantity, d.d_day, d.start_date, d.d_id from delivery d,item i, customer c, roundsman r where i.name=? AND d.e_id=r.e_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number";
		}
		else if(category.equals("c.name"))
		{
			query = "select i.name,i.price,i.data, c.name, c.phone, c.cu,c.dong,c.address,d.quantity, d.d_day, d.start_date, d.d_id from delivery d,item i, customer c, roundsman r where c.name=? AND d.e_id=r.e_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number";
		}
		else if(category.equals("c.dong"))
		{
			query = "select i.name,i.price,i.data, c.name, c.phone, c.cu,c.dong,c.address,d.quantity, d.d_day, d.start_date, d.d_id from delivery d,item i, customer c, roundsman r where c.dong=? AND d.e_id=r.e_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number";
		}
		
		System.out.println(target);
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.setString(1,target);
		ResultSet rs3 = pstmt.executeQuery();

		%>	
		<table border="1">
		<tr>
		<td>item</td>
		<td>price</td>
		<td>i_data</td>
		<td>customer</td>
		<td>c_phone</td>
		<td>c_cu</td>
		<td>c_dong</td>
		<td>c_address</td>
		<td>quantity</td>
		<td>d_day</td>
		<td>start_date</td>

		</tr>
	<%	while(rs3.next())
		{
			String name = rs3.getString(1);
			int price = rs3.getInt(2);
			int i_date = rs3.getInt(3);
			String customer = rs3.getString(4);
			int phone = rs3.getInt(5);
			String cu = rs3.getString(6);
			String dong = rs3.getString(7);
			String address = rs3.getString(8);
			int quantity = rs3.getInt(9);
			int d_day = rs3.getInt(10);
			Date start_date = rs3.getDate(11);
			int d_id = rs3.getInt(12);
			
			
			%>
			<tr>
				<td><%=name%></td>
				<td><%=price%></td>
				<td><%=i_date%></td>
				<td><%=customer%></td>
				<td><%=phone%></td>
				<td><%=cu%></td>
				<td><%=dong%></td>
				<td><%=address%></td>
				<td><%=quantity%></td>
				<td><%=d_day%></td>
				<td><%=start_date%></td>
			</tr>	
	<%
		}
		%>
		</table>
		<%
		rs.close();
		rs2.close();
		rs3.close();
		conn.commit();
		conn.setAutoCommit(true);
		stmt.close();
		conn.close();
		
	} catch(Exception e) {
	
		System.err.println("sql error = " + e.getMessage());
	}

%>
</body>
</html>