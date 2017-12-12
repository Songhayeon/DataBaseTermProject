<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
      request.setCharacterEncoding("euc-kr");
 
      String item_sn = request.getParameter("serial");
      String name = request.getParameter("name");
      String cate = request.getParameter("cate");

      String price = request.getParameter("price");
      String day = request.getParameter("d_d");
      
      
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
  
            String sql2 = "insert into ITEM(SERIAL_NUMBER, name, CATEGORIZE, price, EXPIRATION_DATE) values(?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setInt(1, Integer.parseInt(item_sn));
    		pstmt.setString(2, name);
    		pstmt.setString(3, cate);
    		pstmt.setInt(4, Integer.parseInt(price));
    		pstmt.setInt(5, Integer.parseInt(day));
            
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
<jsp:include page="./managerm2.jsp"></jsp:include>
</body>
</html>