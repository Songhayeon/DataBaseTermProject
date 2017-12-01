<%@ page contentType = "text/html; charset=euc-kr" %>
 
<html>
<head><title>레코드 삽입(추가)예제</title></head>
<body>
      <h3>members 테이블에 레코드 삽입(추가)예제</h3>
 
  	<form method = "post" action = "insert.jsp">
      아이디 : <input type = "text" name = "id"><p>
      패스워드 : <input type = "password" name = "passwd"><p>
      이름 : <input type = "text" name = "name"><p>
      전화번호 : <input type = "text" name = "phone"><p>
      주소(구) : <input type = "text" name = "address_Gu"><p>
      주소(동) : <input type = "text" name = "address_Dong"><p>
      주소(상세) : <input type = "text" name = "address_Detail"><p>
            <input type = "submit" value = "보내기">
      </form>
</body>
</html>