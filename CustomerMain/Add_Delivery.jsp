<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
      request.setCharacterEncoding("euc-kr");
 
      String item_sn = request.getParameter("item");
      String quantity = request.getParameter("Quantity");
      String[] day = request.getParameterValues("Day");
      int nday=0;
      for(String val: day)
      {
    	  nday+=Integer.parseInt(val);
      }
      
      Timestamp register = new Timestamp(System.currentTimeMillis());

      System.out.println(item_sn);
      
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
  
            String sql2 = "insert into DELIVERY(C_ID, SERIAL_NUMBER, D_DAY, QUANTITY, START_DATE) values((select C_ID from customer where ID=?),(select SERIAL_NUMBER from ITEM where NAME=?),?,?,?)";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, id);
    		pstmt.setString(2, item_sn);
    		pstmt.setInt(3, nday);
    		pstmt.setInt(4, Integer.parseInt(quantity));
    		pstmt.setTimestamp(5, register);
            
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
<title>Insert title here</title>
</head>
<body>
<jsp:include page="./customerm.jsp"></jsp:include>
</body>
</html>