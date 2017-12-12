<%@ page contentType = "text/html; charset=euc-kr" %>
<%@page import="bean.LoginDao"%>
<%@ page import = "java.sql.*" %>
<jsp:useBean id="obj" class="bean.LoginBean"/>

<jsp:setProperty property="*" name="obj"/>

<%
boolean status=LoginDao.validate(obj);
if(status){
	String id= obj.getEmail();
	session.setAttribute("sessionID",id);
	
	if(obj.getRadioValue() == 1)	//Á÷¿ø
	{
		Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs =null;
	      int n=0;
	      boolean flag = false;
	      // Connection/PreparedStatement/ResultSet ==> interface
		try
	      {
	    	  String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
	  		String user = "kdhong";
	  		String pass = "kdhong";
	  
	            Class.forName("oracle.jdbc.driver.OracleDriver");
	            conn = DriverManager.getConnection(url, user, pass);
	  
		            String sql1 = "select count(*) num from BRANCH where EID=(select R_ID from ROUNDSMAN where ID=?)";
		            pstmt = conn.prepareStatement(sql1);
		            pstmt.setString(1, id);
		    	
		    		pstmt.executeUpdate();
		    		rs=pstmt.executeQuery();
		  		  	while(rs.next()) {
		    			if(rs.getInt("num") >0)
		    			{
		    				flag = true;
		    			}
		  		  	}
		  		  	
		  		  	rs.close();
		  		  
	      }catch(Exception e){
	            e.printStackTrace();
	      }finally{
	            if(pstmt != null) try { pstmt.close(); } catch(SQLException sqle) {}
	            if(conn != null) try { conn.close(); } catch(SQLException sqle) {}
	      }
	      
	      if(flag)
	      {
	    	  response.sendRedirect("../manager/managerm2.jsp");
	      }
	      else
	      {
	    	  response.sendRedirect("../roundsman/sample.jsp");
	      }	
	}
	else	//°í°´
	{
		
		response.sendRedirect("../CustomerMain/customerm.jsp");
	}
	
}
else
{
out.print("Sorry, id or password error");
%>
<jsp:include page="index.jsp"></jsp:include>
<%
}
%>