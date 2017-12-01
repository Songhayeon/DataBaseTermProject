<%@ page contentType = "text/html; charset=euc-kr" %>
 
<script type="text/javascript">

    function goSubmit() {
    	window.location.replace("../Consumer/consumer.jsp");
    }
</script>

<form action="loginprocess.jsp">
ID:<input type="text" name="email"/><br/><br/>
Password:<input type="password" name="pass"/><br/><br/>

EMP : <input type="radio" name="radioValue" value=1>
CONSUMER : <input type="radio" name="radioValue" value=2>

<input type="submit" value="login"/>

<input type="button" onclick="goSubmit()" value="register">

</form>