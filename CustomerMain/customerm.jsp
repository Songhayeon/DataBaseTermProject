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
	String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
		String user = "kdhong";
		String pass = "kdhong";
		ALLid = (String)session.getAttribute("sessionID");
		
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
	    	  String sql_customer = "select C_ID, NAME from customer where ID=?";
			    pstmt = conn.prepareStatement(sql_customer);
			    pstmt.setString(1, ALLid);
			  	pstmt.executeUpdate();
			  
			  rs=pstmt.executeQuery();
			  while(rs.next()) {
				  allcid=rs.getInt("C_ID");
				  username=rs.getString("NAME");
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

       <td><%=username %> �� �ȳ��ϼ���.<a href="modifyinfo.jsp?id=<%=allcid%>" >��������</a> <a href="logout.jsp" >�α׾ƿ�</a> </td>
       
</form>

<form action="./Add_Delivery.jsp" method="post">
        <select name="item">
        <%  for(int count = 0; count < lin.size(); count++){ %>
            <option><%=lis.get(count)%></option>
        <% } %>
        </select>
        ���� : <input type = "text" name = "Quantity">
        <input type="checkbox" name="Day" value="10000"> ��
        <input type="checkbox" name="Day" value="1000"> ȭ
        <input type="checkbox" name="Day" value="100"> ��
        <input type="checkbox" name="Day" value="10"> ��
        <input type="checkbox" name="Day" value="1"> ��
        <input type = "submit" value="ADD">
</form>

<h2>�ֹ����</h2>
<table border="1" width="600">
	<tr>
		<td>��ǰ�̸�</td>
		<td>��</td>
		<td>���� ��¥</td>
		<td>��</td>
		<td>ȭ</td>
		<td>��</td>
		<td>��</td>
		<td>��</td>
		<td>����</td>
		<td>����</td>
	</tr>
	<%
		//db ���� ȸ����� ���� ���̺� ����ϱ�.

		try{
			
			String sql1 = "select C_ID, SERIAL_NUMBER, D_DAY, QUANTITY, START_DATE from DELIVERY d where C_ID=(select C_ID from customer where ID=?)";
			
			pstmt = conn.prepareStatement(sql1);
			
		    pstmt.setString(1, ALLid);
		  	pstmt.executeUpdate();
		  	
		  	rs=pstmt.executeQuery();
		  while(rs.next()) {
			 
			int cid = rs.getInt("C_ID");
			int sn = rs.getInt("SERIAL_NUMBER");
			int dday=  rs.getInt("D_DAY");
			int quan = rs.getInt("QUANTITY");
			Date d = rs.getDate("START_DATE");
			String name_item=null;
			int monday = 0;
			int tuesday = 0;
			int wednesday = 0;
			int thursday = 0;
			int friday = 0;
			
			if((dday/10000) ==1)
			{
				monday = 1;
				dday%=10000;
			}			
			
			if((dday/1000) ==1)
			{
				tuesday = 1;
				dday%=1000;
			}
			
			if((dday/100) ==1)
			{
				wednesday = 1;
				dday%=100;
			}
			
			if((dday/10) ==1)
			{
				thursday = 1;
				dday%=10;
			}
			
			if((dday/1) ==1)
			{
				friday = 1;
				dday%=1;
			}
			name_item = lis.get(lin.indexOf(Integer.toString(sn)));
%>
	<tr>
		<td><%=name_item %></td>
		<td><%=quan %></td>
		<td><%=d %></td>
		<td><%=monday %></td>
		<td><%=tuesday %></td>
		<td><%=wednesday %></td>
		<td><%=thursday %></td>
		<td><%=friday %></td>
		<td><a href="customerdelete.jsp?id=<%=sn%>" >����</a></td>
		<td><a href="customerupdate.jsp?id=<%=sn%>&name=<%=(java.net.URLEncoder.encode(name_item,"UTF-8"))%>" >����</a></td>
		
		
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
		}
	%>



</body>
</html>