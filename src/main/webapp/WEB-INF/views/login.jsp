<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Log in</h1>
<p style="color:blue;">${signUpSuccessful}</p>
<p style="color:blue;">${logOutSuccessful}</p>
<p style="color:red;">${invalidCredentials}</p>
<form action="${pageContext.request.contextPath}/login" method="post">
	<table>
		<tr>
			<td>Username: </td><td><input type="text" name="username" required="required"/></td>
		</tr>
		<tr>
			<td>Password: </td><td><input type="password" name="password" required="required"/></td>
		</tr>
		<tr>
			<td colspan="2" align="right"><input type="submit" value="Log in"/></td>
		</tr>
		<tr>
			<td colspan="2" align="right"><a href="${pageContext.request.contextPath}/signup">Sign up an account</a></td>
		</tr>
	</table>
</form>

</body>
</html>