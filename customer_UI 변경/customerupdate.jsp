<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=0, width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

<title>better look &amp; better delivery DB Team Project Web
	Template</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/mobile.css">
<script type='text/javascript' src='js/mobile.js'></script>
</head>
<body>
<%

request.setCharacterEncoding("euc-kr");

String item_sn = request.getParameter("id");
String iname = request.getParameter("name");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;
	String id = (String)session.getAttribute("sessionID");
	int cid ;
	int sn;
	int dday;
	int quan ;
	Date d ;
	String name_item=null;
	boolean monday = false;
	boolean tuesday = false;
	boolean wednesday = false;
	boolean thursday = false;
	boolean friday = false;
	try
    {
		String url = "jdbc:oracle:thin:@localhost:1158/em";
  		String user = "orcl1";
  		String pass = "qwer1234Z";
		
          Class.forName("oracle.jdbc.driver.OracleDriver");
          conn = DriverManager.getConnection(url, user, pass);
			
          String sql2 = "select C_ID, SERIAL_NUMBER, D_DAY, QUANTITY, START_DATE from DELIVERY d where C_ID=(select C_ID from customer where ID=?) and SERIAL_NUMBER = ?";
          pstmt = conn.prepareStatement(sql2);
          pstmt.setString(1, id);
  		pstmt.setString(2, item_sn);

  		
  		rs = pstmt.executeQuery();
  		while(rs.next())
  		{
  		 cid = rs.getInt("C_ID");
		sn = rs.getInt("SERIAL_NUMBER");
		 dday=  rs.getInt("D_DAY");
		 quan = rs.getInt("QUANTITY");
		 d = rs.getDate("START_DATE");
		 name_item=null;
		
		if((dday/10000) ==1)
		{
			monday = true;
			dday%=10000;
		}			
		
		if((dday/1000) ==1)
		{
			tuesday = true;
			dday%=1000;
		}
		
		if((dday/100) ==1)
		{
			wednesday = true;
			dday%=100;
		}
		
		if((dday/10) ==1)
		{
			thursday = true;
			dday%=10;
		}
		
		if((dday/1) ==1)
		{
			friday = true;
			dday%=1;
		}
  		
  
	

%>
<form name='frm1' method='post' action='customerupdateok.jsp'>

<div id="header">
		<h1>
			<a href="index.html">better look &amp; better delivery 
			<span>DB Team Project</span></a>
		</h1>
		</div>
		<div id="body">
<table>
	<tr>
		<td>제품이름</td>
		<td><%=iname %><input type="hidden" name="itemname" value="<%=iname%>"/></td>
	</tr>
	<tr>
		<td>양</td>
		<td><input type="text" name="quantity" value="<%=Integer.toString(quan)%>"/></td>
	</tr>
	<tr>
		<td>등록일</td>
		<td><input type="text" name="date" value="<%=d %>"/></td>
	</tr>
	<tr>
		<td>날짜</td>
		<td>월<input type="checkbox" name="Day" id="ch" value="10000"/></td>
		<td>화<input type="checkbox" name="Day" id="ch" value="1000"/></td>
		<td>수<input type="checkbox" name="Day" id="ch" value="100"/></td>
		<td>목<input type="checkbox" name="Day" id="ch" value="10"/></td>
		<td>금<input type="checkbox" name="Day" id="ch" value="1"/></td>
		<script language="javascript" type="text/javascript">
			
			document.frm1.Day[0].checked=<%=monday%>;
			document.frm1.Day[1].checked=<%=tuesday%>;
			document.frm1.Day[2].checked=<%=wednesday%>;
			document.frm1.Day[3].checked=<%=thursday%>;
			document.frm1.Day[4].checked=<%=friday%>;
        </script>
	</tr>
	<tr>
	
	</tr>
	<tr>
		<td colspan="2" align="center">
		<input type="button" name="btn1" value="저장" onclick="javascript:frm1.submit();"/>
		<input type="button" name="btn2" value="목록" onclick="javascript:location.href='./customerm.jsp'";/>
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