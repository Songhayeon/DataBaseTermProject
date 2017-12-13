<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Random"%>

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
	<div id="header">
		<h1>
			<a href="Roundsman.jsp">better look &amp; better delivery <span>DB
					Term Project</span></a>

		</h1>
		<h1>나의정보</h1>

		<ul id="navigation">
			<li class="current"><a href="Roundsman.jsp">My delivery list</a></li>
			<li><a href="Roundsman.jsp">Search my list</a></li>
		</ul>
	</div>
	<div id="body">

		</table>

		</br>
		<p>
			<b>Search my lists</b>
			
		</p>
			</br>
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
				<td>      </td>
				<td><input type="text" name="search_target" /></td>
				<td><button>조회</button></td>
			</tr>
		</form>
		<%-- 	<%
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

		%>	 --%>
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
			<%-- 	<%	while(rs3.next())
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
		%> --%>
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

