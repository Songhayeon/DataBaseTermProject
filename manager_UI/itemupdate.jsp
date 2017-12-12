<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=0, width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<title>better look &amp; better delivery DB Term Project Web Template</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/mobile.css">
<script type='text/javascript' src='js/mobile.js'></script>
</head>
<body>
<%

request.setCharacterEncoding("euc-kr");

String iid = request.getParameter("id");


	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;
	String id = (String)session.getAttribute("sessionID");
	
	try
    {
  	  String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
		String user = "kdhong";
		String pass = "kdhong";
		
          Class.forName("oracle.jdbc.driver.OracleDriver");
          conn = DriverManager.getConnection(url, user, pass);
			
          String sql2 = "select SERIAL_NUMBER, name, CATEGORIZE, PRICE, EXPIRATION_DATE FROM item WHERE SERIAL_NUMBER=?";
		  pstmt = conn.prepareStatement(sql2);
          pstmt.setString(1, iid);
  		
          
   
  		
  		rs = pstmt.executeQuery();
  		while(rs.next())
  		{  	 
  			int sn = rs.getInt("SERIAL_NUMBER");
			String name_item=rs.getString("NAME");
			String cate = rs.getString("CATEGORIZE");
			int price = rs.getInt("Price");
			int dday=  rs.getInt("EXPIRATION_DATE");
%>
<form name='frm1' method='post' action='itemupdateok.jsp'>
<div id="header">
		<h1>
			<a href="index.html">better look &amp; better delivery 
			<span>DB Term Project</span></a>
		</h1>
		<ul id="navigation">
			<li><a href="managerm2.jsp">Item_List</a></li>
			<li><a href="managerm_item.jsp">Employee List</a></li>
		</ul>
	</div>
	<div id="body">
<table>
	
	<tr>
		
		<td><input type="hidden" name="sn" value="<%=sn%>"/></td>
	</tr>
	<tr>
		<td>아이템 이름</td>
		<td><%=name_item %><input type="text" name="name" value="<%=name_item%>"/></td>
	</tr>
	<tr>
		<td>카테고리</td>
		<td><input type="text" name="cate" value="<%=cate%>"/></td>
	</tr>
	<tr>
		<td>가격</td>
		<td><input type="text" name="price" value="<%=price %>"/></td>
	</tr>
	<tr>
		<td>유통기한</td>
		<td><input type="text" name="dday" value="<%=dday %>"/></td>
	</tr>
	
	
	<tr>
		<td colspan="2" align="center">
		<input type="button" name="btn1" value="저장" onclick="javascript:frm1.submit();"/>
		<input type="button" name="btn2" value="목록" onclick="javascript:location.href='./managerm_item.jsp'";/>
		</td>
	</tr>
</table>
	</div>
</form>		
<%}
	}catch(SQLException se){
		System.out.println(se.getMessage());
	}finally{
		try{
			if(rs!=null)  rs.close();
			if(pstmt!=null)  pstmt.close();
			if(conn!=null)  conn.close();
		}catch(SQLException se){
			System.out.println(se.getMessage());
		}
	}
%>

<script type="text/javascript">
	function update(){
		document.frm1.submit();
	}
	function list(){
		location.href="list.jsp";
	}
</script>
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