<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
      request.setCharacterEncoding("euc-kr");
 		String pk = request.getParameter("cid_pk");
      String pw = request.getParameter("passwd");
      String na = request.getParameter("name");
      String ph = request.getParameter("phone");
      String agu = request.getParameter("address_Gu");
      String ado = request.getParameter("address_Dong");
      String ade = request.getParameter("address_Detail");
      
      Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs=null;
  		String id = (String)session.getAttribute("sessionID");
  		int n =0;
      // Connection/PreparedStatement/ResultSet ==> interface
      
      try
      {
    	  String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
  		String user = "kdhong";
  		String pass = "kdhong";
  
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
           
            String sql2 = "update CUSTOMER set PASSWD=?, NAME=?, PHONE=?, ADDRESS_GU=?, ADDRESS_DONG=?, ADDRESS_DETAIL=? where C_ID=?";
            pstmt = conn.prepareStatement(sql2);
            
            pstmt.setString(1, pw);
            pstmt.setString(2, na);
            pstmt.setString(3, ph);
            pstmt.setString(4, agu);
            pstmt.setString(5, ado);
            pstmt.setString(6, ade);
            pstmt.setString(7, pk);

        	
    		
    		
            
    		n=pstmt.executeUpdate();
    		
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