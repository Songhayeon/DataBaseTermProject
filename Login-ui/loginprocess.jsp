<%@ page contentType = "text/html; charset=euc-kr" %>
<%@page import="bean.LoginDao"%>
<jsp:useBean id="obj" class="bean.LoginBean"/>

<jsp:setProperty property="*" name="obj"/>

<%
boolean status=LoginDao.validate(obj);
if(status){
	%>
	<jsp:include page="../CustomerMain/customermainindex.jsp"></jsp:include>
	<%
session.setAttribute("session","TRUE");

}
else
{
out.print("Sorry, email or password error");
%>
<jsp:include page="index.jsp"></jsp:include>
<%
}
%>