<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@page import="bean.convert"%>
<jsp:useBean id="obj" class="bean.convert"/>

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
	PreparedStatement pstmt=null;
	String ALLid = (String)session.getAttribute("sessionID");
	
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("드라이버 검색 성공!");
	}catch(ClassNotFoundException e) {
		System.err.println("error = " + e.getMessage());
		System.exit(1);
	}

	try{
		conn = DriverManager.getConnection(url,user,pass);

		
	}catch(SQLException e) {
		System.err.println("sql error = " + e.getMessage());
		System.exit(1);

	}
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("select r_id,name,phone,gu,dong from roundsman where id=?");
			pstmt.setString(1,ALLid);
			ResultSet rs = pstmt.executeQuery();
			{
			rs.next();
			int r_id = rs.getInt(1);
			String name = rs.getString("name");
			String phone = rs.getString("phone");
			String gu = rs.getString("gu");
			String dong = rs.getString("dong");
			
	%>
	<form>
       <td><%=name %> 님 안녕하세요.<a href="logout.jsp" >로그아웃</a> </td>
     
	</form>
	</br>직원의 정보</br>
	<table width="550"border="1" >
		<tr>
		<td>r_id</td>
		<td>name</td>
		<td>phone</td>
		<td>gu</td>
		<td>dong</td>
		</tr>
	
		<tr>
		<td><%=r_id%></td>
		<td><%=name%></td>
		<td><%=phone%></td>
		<td><%=gu%></td>
		<td><%=dong%></td>
		</tr>
		
		</table>
		<% } %>
		</br></br>직원의 전체 배달목록 </br>
		<%
		pstmt = conn.prepareStatement("select i.name,i.price,i.categorize, c.name, c.phone, c.address_gu,c.address_dong,c.address_detail,d.quantity, d.d_day, d.start_date, i.serial_number,c.c_id from delivery d,item i, customer c, roundsman r where d.r_id=r.r_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number AND r.id=?");
		pstmt.setString(1, ALLid);
		ResultSet rs2 = pstmt.executeQuery();
		%>
		<table border="1">
		<tr>
		<td>물품</td>
		<td>가격</td>
		<td>물품 종류</td>
		<td>고객</td>
		<td>고객 연락처</td>
		<td>구</td>
		<td>동</td>
		<td>상세주소</td>
		<td>양</td>
		<td>배달 요일</td>
		<td>시작 날짜</td>
		</tr>
		<%
		while (rs2.next()) {
			
			String name = rs2.getString(1);
			int price = rs2.getInt(2);
			String categorize = rs2.getString(3);
			String customer = rs2.getString(4);
			String phone = rs2.getString(5);
			String gu = rs2.getString(6);
			String dong = rs2.getString(7);
			String address = rs2.getString(8);
			int quantity = rs2.getInt(9);
			int d_day = rs2.getInt(10);
			Date start_date = rs2.getDate(11);
			int serial_number = rs2.getInt(12);
			int c_id = rs2.getInt(13);
			String getweek = obj.getDayString(obj.getDay(d_day));
		%>
		<tr>
		<td><%=name%></td>
		<td><%=price%></td>
		<td><%=categorize%></td>
		<td><%=customer%></td>
		<td><%=phone%></td>
		<td><%=gu%></td>
		<td><%=dong%></td>
		<td><%=address%></td>
		<td><%=quantity%></td>
		<td><%=getweek%></td>
		<td><%=start_date%></td>
		<td><a href="update.jsp?serial=<%=serial_number%>&c_id=<%=c_id %>">수정</a></td>
		<td><a href="delete.jsp?serial=<%=serial_number %>&c_id=<%=c_id%>">삭제</a></td>
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
			query = "select i.name,i.price,i.categorize, c.name, c.phone, c.address_gu,c.address_dong,c.address_detail,d.quantity, d.d_day, d.start_date from delivery d,item i, customer c, roundsman r where r.id=? AND i.name=? AND d.r_id=r.r_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number";
		}
		else if(category.equals("c.name"))
		{
			query = "select i.name,i.price,i.categorize, c.name, c.phone, c.address_gu,c.address_dong,c.address_detail,d.quantity, d.d_day, d.start_date from delivery d,item i, customer c, roundsman r where r.id=? AND c.name=? AND d.r_id=r.r_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number";
		}
		else if(category.equals("c.dong"))
		{
			query = "select i.name,i.price,i.categorize, c.name, c.phone, c.address_gu,c.address_dong,c.address_detail,d.quantity, d.d_day, d.start_date from delivery d,item i, customer c, roundsman r where r.id=? AND c.address_dong=? AND d.r_id=r.r_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number";
		}
		
		
		
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1,ALLid);
		
		pstmt.setString(2,target);
		
		
		ResultSet rs3 = pstmt.executeQuery();

		%>	
		<table border="1">
		<tr>
		<td>물품</td>
		<td>가격</td>
		<td>물품 카테고리</td>
		<td>고객</td>
		<td>고객 연락처</td>
		<td>구</td>
		<td>동</td>
		<td>주소</td>
		<td>갯수</td>
		<td>배달 요일</td>
		<td>시작 날짜</td>

		</tr>
	<%	while(rs3.next())
		{
			String name = rs3.getString(1);
			int price = rs3.getInt(2);
			String categorize = rs3.getString(3);
			String customer = rs3.getString(4);
			String phone = rs3.getString(5);
			String gu = rs3.getString(6);
			String dong = rs3.getString(7);
			String address = rs3.getString(8);
			int quantity = rs3.getInt(9);
			int d_day = rs3.getInt(10);
			Date start_date = rs3.getDate(11);	
			String getweek = obj.getDayString(obj.getDay(d_day));
			
			%>
			<tr>
				<td><%=name%></td>
				<td><%=price%></td>
				<td><%=categorize%></td>
				<td><%=customer%></td>
				<td><%=phone%></td>
				<td><%=gu%></td>
				<td><%=dong%></td>
				<td><%=address%></td>
				<td><%=quantity%></td>
				<td><%=getweek%></td>
				<td><%=start_date%></td>
			</tr>	
	<%
		}
		%>
		</table>
		<%
		pstmt.close();
		rs.close();
		rs2.close();
		rs3.close();
		
		conn.commit();
		conn.setAutoCommit(true);
		
		conn.close();
		
	} catch(Exception e) {
	
		System.err.println("sql error = " + e.getMessage());
	}

%>
</body>
</html>