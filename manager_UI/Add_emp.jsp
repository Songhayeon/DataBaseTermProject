<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import = "java.sql.*" %>
     <%@ page import = "java.util.Random" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
      request.setCharacterEncoding("euc-kr");



String id = request.getParameter("id");
String pw = request.getParameter("pw");
      String belong = request.getParameter("BELONG_TO");
      String name = request.getParameter("name");
      String phone = request.getParameter("phone");

      String dong = request.getParameter("dong");
      String gu = request.getParameter("gu");
      
      System.out.println(gu);
      Timestamp register = new Timestamp(System.currentTimeMillis());


      int pk=0;//
      Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs=null;
  		//String id = (String)session.getAttribute("sessionID");
      // Connection/PreparedStatement/ResultSet ==> interface
 
    		  Random random = new Random();
    	pk = random.nextInt(10000);
    	boolean check_pk=false;
    		  
      try
      {
    	  String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
    		String user = "kdhong";
    		String pass = "kdhong";
    
              Class.forName("oracle.jdbc.driver.OracleDriver");
              conn = DriverManager.getConnection(url, user, pass);
    	  do
          {
	            String sql1 = "select count(*) num from roundsman where R_ID=?";
	            pstmt = conn.prepareStatement(sql1);
	            pstmt.setInt(1, pk);
	    	
	    		pstmt.executeUpdate();
	    		rs=pstmt.executeQuery();
	  		  	while(rs.next()) {
	    			if(rs.getInt("num") == 1)
	    			{
	    				check_pk = true;
	    				pk = random.nextInt(10000);
	    			}
	    			else
	    			{
	    				check_pk =false;
	    			}
	  		  	}
	  		  	
	  		  	rs.close();
	  		  	pstmt.close();
          }while(check_pk);
    	  
  
            String sql2 = "insert into roundsman(R_ID, name, PHONE, DONG, BELONG_TO, GU,ID,PASSWD) values(?,?,?,?,?,?,?,?)";
            
            
            pstmt = conn.prepareStatement(sql2);
            pstmt.setInt(1, pk);
    		pstmt.setString(2, name);
    		pstmt.setString(3, phone);
    		pstmt.setString(4, dong);
    		pstmt.setInt(5, Integer.parseInt(belong));
    		pstmt.setString(6, gu);
    		pstmt.setString(7, id);
    		pstmt.setString(8, pw);

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