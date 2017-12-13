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

String eid = request.getParameter("id");


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
			
          String sql2 = "select r_id, name, phone, dong, BELONG_TO, GU, ID FROM roundsman WHERE R_ID=?";
		  pstmt = conn.prepareStatement(sql2);
          pstmt.setString(1, eid);
  		
          
   
  		
  		rs = pstmt.executeQuery();
  		while(rs.next())
  		{  	 
  			 int r_id = rs.getInt("r_id");
  	         String name = rs.getString("name");
  	         String phone = rs.getString("phone");
  	         String dong = rs.getString("dong");
  	         int branch = rs.getInt("BELONG_TO");
  	         String gu = rs.getString("GU");
  	         String IDENTI = rs.getString("ID");
  	       
%>
<form name='frm1' method='post' action='empupdateok.jsp'>
<div id="header">
		<h1>
			<a href="index.html">better look &amp; better delivery <span>DB
					Term Project</span></a>
		</h1>
				<ul id="navigation">
			<li><a href="managerm2.jsp">Item_List</a></li>
			<li><a href="managerm_item.jsp">Employee List</a></li>
		</ul>
	</div>
	<div id="body">
<table>
	
	<tr>
		<td>직원번호</td>
		<td><%=r_id %><input type="hidden" name="rid" value="<%=r_id%>"/></td>
	</tr>
	<tr>
		<td>직원이름</td>
		<td><input type="text" name="ename" value="<%=name%>"/></td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td><input type="text" name="phone" value="<%=phone%>"/></td>
	</tr>
	<tr>
		<td>동</td>
		<td><input type="text" name="dong" value="<%=dong %>"/></td>
	</tr>
	<tr>
		<td>구</td>
		<td><input type="text" name="gu" value="<%=gu %>"/></td>
	</tr>
	
	
	<tr>
		<td colspan="2" align="center">
		<input type="button" name="btn1" value="저장" onclick="javascript:frm1.submit();"/>
		<input type="button" name="btn2" value="목록" onclick="javascript:location.href='./managerm2.jsp'"/>
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