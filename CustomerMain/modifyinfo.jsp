<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
      request.setCharacterEncoding("euc-kr");
 
      String cid = request.getParameter("id");
      
      Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs=null;
  		String id = (String)session.getAttribute("sessionID");
      // Connection/PreparedStatement/ResultSet ==> interface
 
      String passwd=null;
      String name=null;
      String phone=null;
      String address_Gu=null;
      String address_Dong=null;
      String address_Detail=null;
      
      try
      {
    	  String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
  		String user = "kdhong";
  		String pass = "kdhong";
  
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
  			
            String sql2 = "select PASSWD, NAME, PHONE, ADDRESS_GU, ADDRESS_DONG, ADDRESS_DETAIL from CUSTOMER where C_ID=?";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, cid);
    		
    		pstmt.executeUpdate();
    		
    		rs=pstmt.executeQuery();
			  while(rs.next()) {
				  passwd=rs.getString("PASSWD");
				  name=rs.getString("NAME");
				  phone=rs.getString("PHONE");
				  address_Gu=rs.getString("ADDRESS_GU");
				  address_Dong=rs.getString("ADDRESS_DONG");
				  address_Detail=rs.getString("ADDRESS_DETAIL");
				  }
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
<form method = "post" action = "./modifyinfoupdate.jsp">
	<input type="hidden" name="cid_pk" value="<%=cid%>">
      패스워드 : <input type = "password" name = "passwd" value="<%=passwd %>"><p>
      이름 : <input type = "text" name = "name" value="<%=name%>"><p>
      전화번호 : <input type = "text" name = "phone" value="<%=phone%>"><p>
      주소(구) : <input type = "text" name = "address_Gu" value="<%=address_Gu%>"><p>
      주소(동) : <input type = "text" name = "address_Dong" value="<%=address_Dong%>"><p>
      주소(상세) : <input type = "text" name = "address_Detail" value="<%=address_Detail%>"><p>
            <input type = "submit" value = "보내기">
      </form>
</body>
</html>