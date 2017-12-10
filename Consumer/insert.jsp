<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "java.sql.*" %>
 <%@ page import = "java.util.Random" %>
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
      int pk=0;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs =null;
      int n=0;
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
	            String sql1 = "select count(*) num from CUSTOMER where C_ID=?";
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
            
            String sql = "insert into customer values(?,?,?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, pk);
    		pstmt.setString(2, id);
    		pstmt.setString(3, passwd);
    		pstmt.setString(4, name);
    		pstmt.setString(5, phone);
    		pstmt.setString(6, address_Gu);
    		pstmt.setString(7, address_Dong);
    		pstmt.setString(8, address_Detail);
    		pstmt.setTimestamp(9, register);
            
    		n=pstmt.executeUpdate();
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
      <script type="text/javascript">
	if(<%=n%>>0 ){
		alert("추가되었습니다.");
		location.href="../Login/index.jsp";
	}else{
		alert("추가 실패 id가 같습니다.");
		history.go(-1);
	}
</script>
      
</body>
</html>