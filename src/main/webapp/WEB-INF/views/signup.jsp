<%@ include file="template/header.jspf" %>
</head>
<body onload="getActivePage()">
	<%@ include file="template/nav-bar.jspf" %>
	
	<div class="container" style="width:40%;">
		<h2 class="text-center">Sign up</h2>
		<p class="text-danger">${usernameExists}</p>
		<p class="text-danger">${emailExists}</p>	
		
		<form action="${pageContext.request.contextPath}/signup" method="post">
			<div class="form-group has-feedback">
				<label class="control-label" for="username">Username:</label>
				<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
				  	<input type="text" class="form-control" id="username" name="username" required="required"
				  			placeholder="Enter your username" onchange="checkNotNull('username'), enableSubmitButton()"/>		
				</div>
				<span></span>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="password">Password:</label>
				<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
				  	<input type="password" class="form-control" id="password" name="password" required="required"
				  			onchange="passwordValidation(), checkConfirmPassword(), enableSubmitButton()"
				  			pattern="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
				  			placeholder="Enter your password"/>
				</div>				
				<span></span>
				<div id="pwdNotValid" class="hidden">
					<p style="margin:0; padding:0;"><small>Password requirements:</small></p>
					<ul>
						<li><small>Must have at least 8 characters.</small></li>
						<li><small>Must have at least 1 upper-case English letter.</small></li>
						<li><small>Must have at least 1 lower-case English letter.</small></li>
						<li><small>Must have at least 1 number.</small></li>
						<li><small>Must have at least 1 special character.</small></li>
					</ul>
				</div>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="confirm">Confirm Password:</label>
			  	<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
				  	<input type="password" class="form-control" id="confirm" name="confirmPassword" required="required"
				  			pattern="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
				  			onchange="checkConfirmPassword(), enableSubmitButton()"
				  			placeholder="Confirm your password"/>
				</div>
				<span></span>
				<div id="cfmNotValid" class="hidden">
					<p><small>Password and Confirm Password does not match.</small></p>
				</div>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="firstName">First Name:</label>
				<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
				  	<input type="text" class="form-control" id="firstName" name="firstName" required="required"
				  			placeholder="Enter your first name" onchange="checkNotNull('firstName'), enableSubmitButton()"/>		
				</div>		
				<span></span>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="lastName">Last Name:</label>
			  	<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
				  	<input type="text" class="form-control" id="lastName" name="lastName" required="required"
				  			placeholder="Enter your last name" onchange="checkNotNull('lastName'), enableSubmitButton()"/>				
				</div>
				<span></span>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="email">Email:</label>
			  	<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
				  	<input type="text" class="form-control" id="email" name="email" required="required"
				  			pattern="[^@]+@[^@]+\.[a-zA-Z]{2,6}" onchange="emailValidation(), enableSubmitButton()"
				  			placeholder="Enter your email"/>				
				</div>
				<span></span>
				<div id="emailNotValid" class="hidden">
					<p><small>Please enter a valid email.</small></p>
				</div>
			</div>
			<button id="submitButton" type="submit" class="btn btn-block btn-primary" disabled="disabled">Sign up</button>
		</form>
	</div>
	
	<script type="text/javascript">
		
		function enableSubmitButton() {
			if(document.getElementsByClassName("glyphicon-remove")[0] == null && isAllFilled()) {
				document.getElementById("submitButton").disabled = false;
			} else {
				document.getElementById("submitButton").disabled = true;
			}
		}
		
		function isAllFilled() {
			var username = document.getElementById("username").value;
			var password = document.getElementById("password").value;
			var confirm = document.getElementById("confirm").value;
			var firstName = document.getElementById("firstName").value;
			var lastName = document.getElementById("lastName").value;
			var email = document.getElementById("email").value;
			if(username !== null && username !== ""
					&& password !== null && password !== ""
					&& confirm !== null && confirm !== ""
					&& firstName !== null && firstName !== ""
					&& lastName !== null && lastName !== ""
					&& email !== null && email !== "") {
				return true;
			} else {
				return false;
			}
		}
		
		function checkNotNull(elementId) {
			var element = document.getElementById(elementId);
			if(element.value !== null && element.value.trim() !== "") {
				element.parentElement.parentElement.className = "form-group has-success has-feedback";
				element.parentElement.nextElementSibling.className = "glyphicon glyphicon-ok form-control-feedback";
			} else {
				element.parentElement.parentElement.className = "form-group has-error has-feedback";
				element.parentElement.nextElementSibling.className = "glyphicon glyphicon-remove form-control-feedback";
			}
			
		}
	
		function checkConfirmPassword() {
			var pwdElement = document.getElementById("password");
			var cfmPwdElement = document.getElementById("confirm");
			if(new String(pwdElement.value).valueOf() === new String(cfmPwdElement.value).valueOf()) {
				document.getElementById("cfmNotValid").className = "hidden";
				cfmPwdElement.parentElement.parentElement.className = "form-group has-success has-feedback";
				cfmPwdElement.parentElement.nextElementSibling.className = "glyphicon glyphicon-ok form-control-feedback";
			} else {
				document.getElementById("cfmNotValid").className = "show text-danger";
				cfmPwdElement.parentElement.parentElement.className = "form-group has-error has-feedback";
				cfmPwdElement.parentElement.nextElementSibling.className = "glyphicon glyphicon-remove form-control-feedback";
			}
		}
		
		
		function passwordValidation() {
			var pwdElement = document.getElementById("password");
			var regex = new RegExp(document.getElementById("password").pattern);
			if(regex.test(pwdElement.value)) {
				document.getElementById("pwdNotValid").className = "hidden";
				pwdElement.parentElement.parentElement.className = "form-group has-success has-feedback";
				pwdElement.parentElement.nextElementSibling.className = "glyphicon glyphicon-ok form-control-feedback";
			} else {
				document.getElementById("pwdNotValid").className = "show text-danger";
				pwdElement.parentElement.parentElement.className = "form-group has-error has-feedback";
				pwdElement.parentElement.nextElementSibling.className = "glyphicon glyphicon-remove form-control-feedback";
			}
			
		}
		
		function emailValidation() {
			var emailElement = document.getElementById("email");
			var regex = new RegExp(document.getElementById("email").pattern);
			if(regex.test(emailElement.value)) {
				document.getElementById("emailNotValid").className = "hidden";
				emailElement.parentElement.parentElement.className = "form-group has-success has-feedback";
				emailElement.parentElement.nextElementSibling.className = "glyphicon glyphicon-ok form-control-feedback";
			} else {
				document.getElementById("emailNotValid").className = "show text-danger";
				emailElement.parentElement.parentElement.className = "form-group has-error has-feedback";
				emailElement.parentElement.nextElementSibling.className = "glyphicon glyphicon-remove form-control-feedback";
			}
		}
	</script>
</body>
</html>