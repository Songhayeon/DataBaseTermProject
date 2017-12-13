<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@page import="bean.convert"%>
<jsp:useBean id="obj" class="bean.convert" />


<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=0, width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<title>better look &amp; better delivery DB Term Project Web
	Template</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<link rel="stylesheet" type="text/css" href="../css/mobile.css">
<script type='text/javascript' src='../js/mobile.js'></script>
</head>
<body>
	<%
		int row = 1;
	%>
	<%
		String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
		String user = "kdhong";
		String pass = "kdhong";
		Connection conn = null;
		String sql = null;
		String query = null;
		PreparedStatement pstmt = null;
		String ALLid = (String) session.getAttribute("sessionID");

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버 검색 성공!");
		} catch (ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
			System.exit(1);
		}

		try {
			conn = DriverManager.getConnection(url, user, pass);

		} catch (SQLException e) {
			System.err.println("2 sql error = " + e.getMessage());
			System.exit(1);

		}
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("select r_id,name,phone,gu,dong from roundsman where id=?");
			pstmt.setString(1, "222");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int r_id = rs.getInt(1);
				String name = rs.getString("name");
				String phone = rs.getString("phone");
				String gu = rs.getString("gu");
				String dong = rs.getString("dong");
			}
		} catch (Exception e) {

			System.err.println("select roundsman info sql error = " + e.getMessage());
		}
	%>
	<div id="header">
		<h1>
			<a href="Roundsman.jsp">better look &amp; better delivery <span>DB
					Term Project</span></a>

		</h1>
		<h1>나의정보</h1>

		<ul id="navigation">
			<li class="current"><a href="Roundsman.jsp">My delivery list</a></li>
			<li><a href="Research_my_list.jsp">Search my list</a></li>
		</ul>
	</div>

	<div id="body">

		</br>
		<p>
			<b>overall delivery lists</b>
		</p>
		</br>

		<%
			pstmt = conn.prepareStatement(
					"select i.name,i.price,i.categorize, c.name, c.phone, c.address_gu,c.address_dong,c.address_detail,d.quantity, d.d_day, d.start_date, i.serial_number,c.c_id from delivery d,item i, customer c, roundsman r where d.r_id=r.r_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number AND r.id=?");
			pstmt.setString(1, ALLid);
			ResultSet rs2 = pstmt.executeQuery();
			
		%>
		<table cellspacing='0'>
				<tr>
					<td>item</td>
					<td>price</td>
					<td>type</td>
					<td>customer</td>
					<td>c_phone</td>
					<td>c_cu</td>
					<td>c_dong</td>
					<td>c_address</td>
					<td>quantity</td>
					<td>d_day</td>
					<td>start_date</td>
				</tr>

			<%
				while (rs2.next()) {
					System.out.println("@@");
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
			<tbody>
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
				<td><a
					href="update.jsp?serial=<%=serial_number%>&c_id=<%=c_id%>">수정</a></td>
				<td><a
					href="delete.jsp?serial=<%=serial_number%>&c_id=<%=c_id%>">삭제</a></td>
			</tr>
			<%
				}
			%>
			</tbody>
		</table>
	</div>

	<div id="footer">
		<div>
			<span>Knu, Dauge, South Korea | 987654321</span>
			<p>&copy; 2023 by better look &amp; better delivery DB Term
				Project. All rights reserved.</p>
		</div>
		<div id="connect">
			<a href="https://freewebsitetemplates.com/go/facebook/" id="facebook"
				target="_blank">Facebook</a> <a
				href="https://freewebsitetemplates.com/go/twitter/" id="twitter"
				target="_blank">Twitter</a> <a
				href="https://freewebsitetemplates.com/go/googleplus/"
				id="googleplus" target="_blank">Google&#43;</a> <a
				href="https://freewebsitetemplates.com/go/pinterest/" id="pinterest"
				target="_blank">Pinterest</a>
		</div>
	</div>
</body>
</html>

