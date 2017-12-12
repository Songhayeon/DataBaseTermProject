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
String name = request.getParameter("name");

String cate = request.getParameter("cate");
String price = request.getParameter("price");
String dday = request.getParameter("dday");
String sn = request.getParameter("sn");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;
	String id = (String)session.getAttribute("sessionID");
// Connection/PreparedStatement/ResultSet ==> interface
int n =0;
try
{
	  String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
	String user = "kdhong";
	String pass = "kdhong";

      Class.forName("oracle.jdbc.driver.OracleDriver");
      conn = DriverManager.getConnection(url, user, pass);

      
      String sql2 = "update item set name=?, CATEGORIZE=?, PRICE=?, EXPIRATION_DATE=? where SERIAL_NUMBER = ?";
      pstmt = conn.prepareStatement(sql2);
      pstmt.setString(1, name);
      pstmt.setString(2, cate);
      pstmt.setString(3, price);
      pstmt.setString(4, dday);
      pstmt.setString(5, sn);
		
	
		
      
		n=pstmt.executeUpdate();
}catch(Exception e){
      e.printStackTrace();
}finally{

	  if(pstmt != null) try { pstmt.close(); } catch(SQLException sqle) {}
	 if(conn != null) try { conn.close(); } catch(SQLException sqle) {}
}
%>

<script type="text/javascript">
	if(<%=n%>>0 ){
		alert("수정되었습니다.");
		location.href="./managerm_item.jsp";
	}else{
		alert("수정 실패");
		history.go(-1);
	}
</script>
</body>
</html>