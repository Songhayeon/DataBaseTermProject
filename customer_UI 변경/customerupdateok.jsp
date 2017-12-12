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
String item_sn = request.getParameter("itemname");

System.out.println(item_sn);

String quantity = request.getParameter("quantity");
String register = request.getParameter("date");
String[] day = request.getParameterValues("Day");
int nday=0;
int n=0;
for(String val: day)
{
	  nday+=Integer.parseInt(val);
}

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

      String sql2 = "update DELIVERY set D_DAY=?, QUANTITY=?, START_DATE=? where C_ID=(select C_ID from customer where ID=?) and SERIAL_NUMBER=(select SERIAL_NUMBER from ITEM where NAME=?)";
      pstmt = conn.prepareStatement(sql2);
      pstmt.setInt(1, nday);
      pstmt.setInt(2, Integer.parseInt(quantity));
      pstmt.setString(3, register);
      pstmt.setString(4, id);
		pstmt.setString(5, item_sn);
		
		
		
      
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
		location.href="./customerm.jsp";
	}else{
		alert("수정 실패");
		history.go(-1);
	}
</script>
</body>
</html>