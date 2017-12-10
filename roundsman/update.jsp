<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>update data</title>
</head>
<body>
<%

	request.setCharacterEncoding("euc-kr");
	String id=request.getParameter("id");

	String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
	String user = "sys as sysdba";
	String pass = "DBLab012345";
	Connection conn = null;
	String sql = null;
	String query = null;
	PreparedStatement pstmt=null;
	ResultSet rs = null;
	
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("����̹� �˻� ����!");
	}catch(ClassNotFoundException e) {
		System.err.println("error = " + e.getMessage());
		System.exit(1);
	}

	try{
		conn = DriverManager.getConnection(url,user,pass);
	//	return conn;
		
	}catch(SQLException e) {
		System.err.println("sql error = " + e.getMessage());
		System.exit(1);
//		return null;
	}
	
	try{
		System.out.println(id+'!');
	//	conn = DBConnection.getCon();
		sql="select  i.name,i.price,i.data, c.name, c.phone, c.cu,c.dong,c.address,d.quantity, d.d_day, d.start_date, d.d_id from delivery d,item i, customer c, roundsman r where d.e_id=r.e_id AND d.c_id=c.c_id AND d.serial_number=i.serial_number AND d.d_id=? ";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);

		rs = pstmt.executeQuery();
		rs.next();
		
			String name = rs.getString(1);
			int price = rs.getInt(2);
			int i_date = rs.getInt(3);
			String c_name = rs.getString(4);
			int phone = rs.getInt(5);
			String cu = rs.getString(6);
			String dong = rs.getString(7);
			String address = rs.getString(8);
			int quantity = rs.getInt(9);
			int d_day = rs.getInt(10);
			Date start_date = rs.getDate(11);
		
%>

<form name='frm1' method='post' action='updateOK.jsp'>
<table>

	<tr>
		<td>��</td>
		<td><%=c_name%></td>
	</tr>
	<tr>
		<td><input type="hidden" name="d_id" value="<%=id %>"/></td>
	</tr>
	<tr>
		<td>��</td>
		<td><input type="text" name="quantity" value="<%=quantity %>"/></td>
	</tr>

	<tr>
		<td>��</td>
		<td><input type="text" name="dong" value="<%=dong %>"/></td>
	</tr>
	
	<tr>
		<td>���ּ�</td>
		<td><input type="text" name="address" value="<%=address %>"/></td>
	</tr>
		
	<tr>
		<td>��ȭ��ȣ</td>
		<td><input type="text" name="phone" value="<%=phone %>"/></td>
	</tr>

	<tr>

		<td colspan="2" align="center">
		<input type="button" name="btn1" value="����" onclick="javascript:frm1.submit();"/>
		</td>

	</tr>

</table>
</form>		

<%

	rs.close();
	conn.commit();
	conn.setAutoCommit(true);
	conn.close();

	} catch(Exception e) {

		System.err.println("sql error = " + e.getMessage());
	}




%>

<script type="text/javascript">

	function update(){

		document.frm1.submit();

	}

	function list(){

		location.href="sample.jsp";

	}

</script>

</body>
</html>