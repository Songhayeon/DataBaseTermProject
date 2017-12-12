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