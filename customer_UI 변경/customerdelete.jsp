<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
      request.setCharacterEncoding("euc-kr");
 
      String item_sn = request.getParameter("id");
      
      Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs=null;
  		String id = (String)session.getAttribute("sessionID");
      // Connection/PreparedStatement/ResultSet ==> interface
 
      try
      {
    	  String url = "jdbc:oracle:thin:@localhost:1158/em";
    		String user = "orcl1";
    		String pass = "qwer1234Z";
  
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
  			
            String sql2 = "delete from DELIVERY where C_ID=(select C_ID from customer where ID=?) and SERIAL_NUMBER = ?";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, id);
    		pstmt.setString(2, item_sn);
    		
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
<jsp:include page="./customerm.jsp"></jsp:include>
</body>
</html>