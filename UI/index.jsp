<%@ page contentType="text/html; charset=euc-kr"%>

<script type="text/javascript">
	function goSubmit() {
		window.location.replace("../Consumer/consumer.jsp");
	}
</script>

<form action="loginprocess.jsp">
	<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=0, width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<title>better look &amp; better delivery DB Term Project Web
	Template</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<link rel="stylesheet" type="text/css" href="../css/mobile.css">
<script type='text/javascript' src='../js/mobile.js'></script>
</head>
<body>
	<div id="header">
		<h1>
			<a href="index.jsp">Better look &amp; Better delivery <span>DB
					Term Project</span></a>
		</h1>
		<ul id="navigation">
			<li class="current"><a href="index.jsp">Home</a></li>
			<li><a href="index.jsp">About</a></li>
			<li><a href="index.jsp">Contact</a></li>
		</ul>
	</div>
	<div id="body">
		<div id="tagline">
			<h1>Delivery</h1>
			<p>For Better Delivery </p>
			<p>&amp;</p> 
			<p>Easy to Use</p>
		</div>
		<img src="../images/delivery.jpg" alt="doing delivery" class="figure">
		<div id="login">
			<br /><br />ID : <input type="text" name="email" /><br />
			<br /> Password : <input type="password" name="pass" /><br />
			<br /> EMP : <input type="radio" name="radioValue" value=1>
				   CONSUMER : <input type="radio" name="radioValue" value=2> <br /><br />
			<input type="submit"  value="login" /> 
			<input type="button"  onclick="goSubmit()" value="register">

		</div>

	</div>

	<div id="footer">
		<div>
			<span>Knu, Dauge, South Korea | 987654321</span>
			<p>&copy; 2023 by better look &amp; better delivery DB Term
				Project. All rights reserved.</p>
		</div>
		<div id="connect">
			<a href="https://freewebsitetemplates.com/go/facebook/" id="facebook"
				target="_blank">Facebook</a> <a
				href="https://freewebsitetemplates.com/go/twitter/" id="twitter"
				target="_blank">Twitter</a> <a
				href="https://freewebsitetemplates.com/go/googleplus/"
				id="googleplus" target="_blank">Google&#43;</a> <a
				href="https://freewebsitetemplates.com/go/pinterest/" id="pinterest"
				target="_blank">Pinterest</a>
		</div>
	</div>
</body>
	</html>

	<!-- 
ID:<input type="text" name="email"/><br/><br/>
Password:<input type="password" name="pass"/><br/><br/>

EMP : <input type="radio" name="radioValue" value=1>
CONSUMER : <input type="radio" name="radioValue" value=2>

<input type="submit" value="login"/>

<input type="button" onclick="goSubmit()" value="register">
 -->
</form>