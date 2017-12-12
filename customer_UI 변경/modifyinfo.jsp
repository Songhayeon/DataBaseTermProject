<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
      request.setCharacterEncoding("euc-kr");
 
      String cid = request.getParameter("id");
      
      Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs=null;
  		String id = (String)session.getAttribute("sessionID");
      // Connection/PreparedStatement/ResultSet ==> interface
 
      String passwd=null;
      String name=null;
      String phone=null;
      String address_Gu=null;
      String address_Dong=null;
      String address_Detail=null;
      
      try
      {
    	  String url = "jdbc:oracle:thin:@localhost:1158/em";
    		String user = "orcl1";
    		String pass = "qwer1234Z";
  
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
  			
            String sql2 = "select PASSWD, NAME, PHONE, ADDRESS_GU, ADDRESS_DONG, ADDRESS_DETAIL from CUSTOMER where C_ID=?";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, cid);
    		
    		pstmt.executeUpdate();
    		
    		rs=pstmt.executeQuery();
			  while(rs.next()) {
				  passwd=rs.getString("PASSWD");
				  name=rs.getString("NAME");
				  phone=rs.getString("PHONE");
				  address_Gu=rs.getString("ADDRESS_GU");
				  address_Dong=rs.getString("ADDRESS_DONG");
				  address_Detail=rs.getString("ADDRESS_DETAIL");
				  }
      }catch(Exception e){
            e.printStackTrace();
      }finally{

		  if(pstmt != null) try { pstmt.close(); } catch(SQLException sqle) {}
		 if(conn != null) try { conn.close(); } catch(SQLException sqle) {}
      }
%>

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
<div id="header">
		<h1>
			<a href="index.html">better look &amp; better delivery 
			<span>DB Team Project</span></a>
		</h1>
		</div>
		<div id="body">
<form method = "post" action = "./modifyinfoupdate.jsp">
	<input type="hidden" name="cid_pk" value="<%=cid%>">
      패스워드 : <input type = "password" name = "passwd" value="<%=passwd %>"><p>
      이름 : <input type = "text" name = "name" value="<%=name%>"><p>
      전화번호 : <input type = "text" name = "phone" value="<%=phone%>"><p>
      주소(구) : <input type = "text" name = "address_Gu" value="<%=address_Gu%>"><p>
      주소(동) : <input type = "text" name = "address_Dong" value="<%=address_Dong%>"><p>
      주소(상세) : <input type = "text" name = "address_Detail" value="<%=address_Detail%>"><p>
            <input type = "submit" value = "보내기">
      </form>
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