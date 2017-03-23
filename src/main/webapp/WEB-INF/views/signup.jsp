<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Sign up</h1>
<p style="color:red;">${usernameExists}</p>
<p style="color:red;">${emailExists}</p>
<p id="validationError" style="color:red;"></p>
<form action="${pageContext.request.contextPath}/signup" method="post">
	<table>
		<tr>
			<td>Username: </td><td><input type="text" name="username" required="required"/></td>
		</tr>
		<tr>
			<td>Password: </td><td><input type="password" name="password" required="required" onchange="passwordValidation()"
				pattern="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"/></td>
		</tr>
		<tr>
			<td>Confirm Password: </td><td><input type="password" name="confirmPassword" required="required"
				pattern="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$" onchange="checkConfirmPassword()"/></td>
		</tr>
		<tr>
			<td>First Name: </td><td><input type="text" name="firstName" required="required"/></td>
		</tr>
		<tr>
			<td>Last Name: </td><td><input type="text" name="lastName" required="required"/></td>
		</tr>
		<tr>
			<td>Email: </td><td><input type="text" name="email" required="required" pattern="[^@]+@[^@]+\.[a-zA-Z]{2,6}"
				onchange="emailValidation()"/></td>
		</tr>
		<tr>
			<td colspan="2" align="right"><input id="submitButton" type="submit" disabled="disabled" value="Sign up"/></td>
		</tr>
		
	</table>
</form>

<script type="text/javascript">
	function checkConfirmPassword() {
		var pwd = document.getElementsByName("password")[0].value;
		var cfmPwd = document.getElementsByName("confirmPassword")[0].value;
		if(new String(pwd).valueOf() === new String(cfmPwd).valueOf()) {
			document.getElementById("validationError").innerHTML = null;
			document.getElementById("submitButton").disabled = false;
		} else {
			document.getElementById("validationError").innerHTML = "Password and Confirm Password does not match."
			document.getElementById("submitButton").disabled = true;
		}
	}
	
	function passwordValidation() {
		var pwd = document.getElementsByName("password")[0].value;
		var regex = new RegExp(document.getElementsByName("password")[0].pattern);
		if(regex.test(pwd)) {
			document.getElementById("validationError").innerHTML = null;
		} else {
			document.getElementById("validationError").innerHTML = "Password must have at least 8 characters and must have at least"
				+ " 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character.";
		}
		
	}
	
	function emailValidation() {
		var email = document.getElementsByName("email")[0].value;
		var regex = new RegExp(document.getElementsByName("email")[0].pattern);
		if(regex.test(email)) {
			document.getElementById("validationError").innerHTML = null;
		} else {
			document.getElementById("validationError").innerHTML = "Invalid email address.";
		}
	}
</script>
</body>
</html>