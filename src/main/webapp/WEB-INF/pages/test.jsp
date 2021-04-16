<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="utf-8">
	    <title>Demo for jQuery validate plugin</title>
	    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
	    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
	     <script src="<c:url value="/resources/js/form.js"/>"></script>
	    <style>
		label.error{
			color: red;
		}
	    </style>
	</head>
	<body>
	<div id="main">
	    <form method="get" id="demoForm" action="">
		<p>
			<label>Username</label>
			<input name="user" type="text" />
		</p>
		<p>
			<label>Password</label>
			<input id="password" type="password" name="password" />
		</p>
		<p>
			<label>Re-Password</label>
			<input id="re-password" type="password" name="re-password" />
		</p>
		<p>
		<input type="submit" value="Register" id="register"/>
		</p>
	    </form>
	</div>
	</body>
</html>
