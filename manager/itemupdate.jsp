<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
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
		<input type="button" name="btn2" value="목록" onclick="javascript:location.href='./managerm2.jsp'";/>
		</td>
	</tr>
</table>
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
</body>
</html>