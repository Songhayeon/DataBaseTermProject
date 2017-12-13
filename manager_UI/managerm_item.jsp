<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %> 

  
 <%! 
	 ArrayList<String> lin;
	 ArrayList<String> lis;	
	 String ALLid;	 
 %>

<script type="text/javascript">

 
</script>

<%
	//String ALLid = (String)session.getAttribute("sessionID");

	request.setCharacterEncoding("euc-kr");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;
	lin = new ArrayList<>();
	lis = new ArrayList<>();	
	int allcid=0;
	String username=null;
	int branch_id=0;
	String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
		String user = "kdhong";
		String pass = "kdhong";
		ALLid = (String)session.getAttribute("sessionID");
		System.out.println(ALLid);
	      Class.forName("oracle.jdbc.driver.OracleDriver");
	      conn = DriverManager.getConnection(url, user, pass);
	      
	      try
			{
	    	  String sql2 = "select SERIAL_NUMBER, NAME from ITEM";
			    pstmt = conn.prepareStatement(sql2);
			  	pstmt.executeUpdate();
			  
			  rs=pstmt.executeQuery();
			  while(rs.next()) {
				  lin.add(Integer.toString(rs.getInt("SERIAL_NUMBER")));
				  lis.add(rs.getString("NAME"));
				  }
			    
			  
			}catch(Exception e){
			    e.printStackTrace();
			}finally{
			  if(rs != null) try { rs.close(); } catch(SQLException sqle) {}
			  if(pstmt != null) try { pstmt.close(); } catch(SQLException sqle) {}
			 
			}
	      
	      try
			{
	    	  String sql_rounds = "select R_ID, NAME, BELONG_TO from roundsman where ID=?";
			    pstmt = conn.prepareStatement(sql_rounds);
			    pstmt.setString(1, ALLid);
			  	pstmt.executeUpdate();
			  
			  rs=pstmt.executeQuery();
			  while(rs.next()) {
				  allcid=rs.getInt("R_ID");
				  username=rs.getString("NAME");
				  branch_id=rs.getInt("BELONG_TO");
				  }
			    
		
			}catch(Exception e){
			    e.printStackTrace();
			}finally{
			  if(rs != null) try { rs.close(); } catch(SQLException sqle) {}
			  if(pstmt != null) try { pstmt.close(); } catch(SQLException sqle) {}
			 
			}
	     
	     
%>
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
<form>

       <td><%=username %> 님 안녕하세요.<a href="logout.jsp" >로그아웃</a> </td>
       
</form>
<div id="body">
<form action="./Add_Item.jsp" method="post">
        SN: <input type = "text" name = "serial" size=10>
        품명 : <input type = "text" name = "name" size=10>
         카테고리 : <input type = "text" name = "cate" size=10>
          가격 : <input type = "text" name = "price" size=10>
           유통기한 : <input type = "text" name = "d_d" size=10>
        <input type = "submit" value="ADD">
</form>

<h2>Item 목록</h2>
<table border="1" width="600">
	<tr>
	<td>item_id</td>
      <td>상품이름</td>
      <td>카테고리</td>
      <td>가격</td>
      <td>유통기한</td>  
      <td>수정</td>
      <td>삭제</td>
	</tr>
	<%
		//db 에서 회원목록 얻어와 테이블에 출력하기.

		try{
			//Statement stmt = conn.createStatement();
			String sql1 = "select * from Item";

		  	
			pstmt = conn.prepareStatement(sql1);
			conn.setAutoCommit(false);
		  	pstmt.executeUpdate();
		  	rs=pstmt.executeQuery();
		  	
		  while(rs.next()) {
			 
			int sn = rs.getInt("SERIAL_NUMBER");
			String name_item=rs.getString("NAME");
			String cate = rs.getString("CATEGORIZE");
			int price = rs.getInt("Price");
			int dday=  rs.getInt("EXPIRATION_DATE");
			
%>
	<tr>		
		<td><%=sn %></td>
		<td><%=name_item %></td>
		<td><%=cate %></td>
		<td><%=price %></td>
		<td><%=dday %></td>
		
		<td><a href="itemupdate.jsp?id=<%=sn%>" >수정</a></td>
		<td><a href="itemdelete.jsp?id=<%=sn%>" >삭제</a></td>
		
		
		</tr>
		<%} 
		
		}catch(SQLException se){
			System.out.println(se.getMessage());
		}finally{
			try{
				if(rs!=null)  rs.close();
				if(pstmt!=null)  pstmt.close();
				
			}catch(SQLException se){
				System.out.println(se.getMessage());
			}
		}
		%>
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