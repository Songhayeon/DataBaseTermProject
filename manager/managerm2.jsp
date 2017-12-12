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
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��</title>
</head>
<body>

<form>

       <td><%=username %> �� �ȳ��ϼ���.<a href="logout.jsp" >�α׾ƿ�</a> </td>
       
</form>

<form action="./Add_Item.jsp" method="post">
        SN: <input type = "text" name = "serial">
        ǰ�� : <input type = "text" name = "name">
         ī�װ� : <input type = "text" name = "cate">
          ���� : <input type = "text" name = "price">
           ������� : <input type = "text" name = "d_d">
        <input type = "submit" value="ADD">
</form>

<h2>Item ���</h2>
<table border="1" width="600">
	<tr>
	<td>item_id</td>
      <td>��ǰ�̸�</td>
      <td>ī�װ�</td>
      <td>����</td>
      <td>�������</td>  
      <td>����</td>
      <td>����</td>
	</tr>
	<%
		//db ���� ȸ����� ���� ���̺� ����ϱ�.

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
		
		<td><a href="itemupdate.jsp?id=<%=sn%>" >����</a></td>
		<td><a href="itemdelete.jsp?id=<%=sn%>" >����</a></td>
		
		
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

	<h3>������ ���</h3>
	<table border="1" width="600">
      <tr>
      
      <td>R_ID</td>
      <td>name</td>
      <td>phone</td>
      <td>dong</td>
      <td>branch</td>
      <td>gu</td>      
      <td>����</td>
      <td>����</td>
      </tr>
      <%
      try{
    	  String sql2 = "select R_ID, name, phone, dong, BELONG_TO, GU, ID FROM roundsman WHERE BELONG_TO=(select BELONG_TO from roundsman where ID=?)";
		  	
			pstmt = conn.prepareStatement(sql2);			
			
			conn.setAutoCommit(false);
			pstmt.setString(1, ALLid);
		  	pstmt.executeUpdate();
		  	rs=pstmt.executeQuery();
		  	
      while (rs.next()) {
               int R_ID = rs.getInt("R_ID");
         String name = rs.getString("name");
         String phone = rs.getString("phone");
         String dong = rs.getString("dong");
         int branch = rs.getInt("BELONG_TO");
         String gu = rs.getString("GU");
         String IDENTI = rs.getString("ID");
         
         if(IDENTI.equals(ALLid))
         {
        	 System.out.println(ALLid);
        	 continue;
         }
      %>
      <tr>
   	<td><%=R_ID%></td>
      <td><%=name%></td>
      <td><%=phone%></td>
      <td><%=dong%></td>
      <td><%=branch%></td>
      <td><%=gu%></td>
      
      <td><a href="empdelete.jsp?id=<%=R_ID%>">����</a></td>
      <td><a href="empupdate.jsp?id=<%=R_ID %>">����</a></td>
      </tr>
      <%
      } 
		
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
		}  %>
<form action="./Add_emp.jsp" method="post">
        �̸� : <input type = "text" name = "name">
         ��ȭ��ȣ : <input type = "text" name = "phone">
          �� : <input type = "text" name = "dong">
      
      <input type = "hidden" name = "BELONG_TO" value="<%=branch_id%>">
           
           �� : <input type = "text" name = "gu">
           ID : <input type = "text" name = "id">
           PW : <input type = "text" name = "pw">
           
        <input type = "submit" value="ADD">
</form>

</body>
</html>