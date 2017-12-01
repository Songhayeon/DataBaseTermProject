<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "java.sql.*" %>
 
 <script type="text/javascript">

    function Goback() {
    	window.location.replace("../Login/index.jsp");
    }
</script>
 
 
<%
      request.setCharacterEncoding("euc-kr");
 
      String id = request.getParameter("id");
      String passwd = request.getParameter("passwd");
      String name = request.getParameter("name");
      String phone = request.getParameter("phone");
      String address_Gu = request.getParameter("address_Gu");
      String address_Dong = request.getParameter("address_Dong");
      String address_Detail = request.getParameter("address_Detail");
      Timestamp register = new Timestamp(System.currentTimeMillis());

      Connection conn = null;
      PreparedStatement pstmt = null;
      // Connection/PreparedStatement/ResultSet ==> interface
 
      try
      {
    	  String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
  		String user = "kdhong";
  		String pass = "kdhong";
  
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
  
            String sql = "insert into customer values(?,?,?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, 3);
    		pstmt.setString(2, id);
    		pstmt.setString(3, passwd);
    		pstmt.setString(4, name);
    		pstmt.setString(5, phone);
    		pstmt.setString(6, address_Gu);
    		pstmt.setString(7, address_Dong);
    		pstmt.setString(8, address_Detail);
    		pstmt.setTimestamp(9, register);
            
    		pstmt.executeUpdate();
      }catch(Exception e){
            e.printStackTrace();
      }finally{
            if(pstmt != null) try { pstmt.close(); } catch(SQLException sqle) {}
            if(conn != null) try { conn.close(); } catch(SQLException sqle) {}
      }
%>
 
<html>
<head><title>레코드 삽입(추가)예제</title></head>
<body>
      members 테이블에 새로운 레코드를 삽입(추가)했습니다.
      <input type="button" onclick="Goback()" value="뒤로가기">
      
</body>
</html>