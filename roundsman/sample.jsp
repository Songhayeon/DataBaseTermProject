<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@page import="bean.convert"%>
<jsp:useBean id="obj" class="bean.convert"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����</title>
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
		System.out.println("����̹� �˻� ����!");
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
       <td><%=name %> �� �ȳ��ϼ���.<a href="logout.jsp" >�α׾ƿ�</a> </td>
     
	</form>
	</br>������ ����</br>
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
		</br></br>������ ��ü ��޸�� </br>
		<%
		pstmt = conn.prepareStatement("select i.name,i.price,i.categorize, c.name, c.phone, c.address_gu,c.address_dong,c.address_detail,d.quantity, d.d_day, d.start_date, i.serial_number,c.c_id from delivery d,item i, customer c, roundsman r where d.r_id=r.r_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number AND r.id=?");
		pstmt.setString(1, ALLid);
		ResultSet rs2 = pstmt.executeQuery();
		%>
		<table border="1">
		<tr>
		<td>��ǰ</td>
		<td>����</td>
		<td>��ǰ ����</td>
		<td>��</td>
		<td>�� ����ó</td>
		<td>��</td>
		<td>��</td>
		<td>���ּ�</td>
		<td>��</td>
		<td>��� ����</td>
		<td>���� ��¥</td>
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
		<td><a href="update.jsp?serial=<%=serial_number%>&c_id=<%=c_id %>">����</a></td>
		<td><a href="delete.jsp?serial=<%=serial_number %>&c_id=<%=c_id%>">����</a></td>
		</tr>
		<%
		}	%>
		</table>
		
		</br></br>�˻�</br>
		<form name='frm2'>
			<tr>
			<select name='search'>
				<option value='' selected>��ȸ���</option>
				<option value='i.name'>������</option>
				<option value='c.name'>���̸�</option>
				<option value='c.dong'>��</option>
			</select>
			</tr>
			<tr>
			<td>�˻��Ұ�</td>
			<td><input type="text" name="search_target"/></td>
			<td><button>��ȸ</button></td>
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
		<td>��ǰ</td>
		<td>����</td>
		<td>��ǰ ī�װ�</td>
		<td>��</td>
		<td>�� ����ó</td>
		<td>��</td>
		<td>��</td>
		<td>�ּ�</td>
		<td>����</td>
		<td>��� ����</td>
		<td>���� ��¥</td>

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