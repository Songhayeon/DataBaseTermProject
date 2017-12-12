<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
      request.setCharacterEncoding("euc-kr");
 
      String sn = request.getParameter("id");
      
      Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs=null;
  		String id = (String)session.getAttribute("sessionID");
      // Connection/PreparedStatement/ResultSet ==> interface

      try
      {
    	  String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
  		String user = "kdhong";
  		String pass = "kdhong";
  
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
           
            String sql2 = "delete from item where SERIAL_NUMBER=?";
            
            pstmt = conn.prepareStatement(sql2);            
            pstmt.setString(1, sn);
            
    		pstmt.executeUpdate();
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
<title>ªË¡¶</title>
</head>
<body>
<jsp:include page="./managerm_item.jsp"></jsp:include>
</body>
</html>