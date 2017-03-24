<%@ include file="template/header.jspf" %>
</head>
<body onload="getActivePage()">
	<%@ include file="template/nav-bar.jspf" %>
	<div class="container" style="width:40%;">
		<h2 class="text-center">Log in</h2>
		<p class="text-primary">${signUpSuccessful}</p>
		<p class="text-primary">${logOutSuccessful}</p>
		<p class="text-danger">${invalidCredentials}</p>
		<form action="${pageContext.request.contextPath}/login" method="post">
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
				  			onchange="checkNotNull('password'), enableSubmitButton()" placeholder="Enter your password"/>
				</div>				
				<span></span>
			</div>
			<button id="logInButton" type="submit" class="btn btn-block btn-primary" disabled="disabled">Log in</button>
			<button id="signUpButton" type="submit" onclick="location.href='${pageContext.request.contextPath}/signup';"
					class="btn btn-block btn-danger">Sign up an Account</button>
		</form>
	</div>
	
	<script type="text/javascript">
		
		function enableSubmitButton() {
			if(document.getElementsByClassName("glyphicon-remove")[0] == null && isAllFilled()) {
				document.getElementById("logInButton").disabled = false;
			} else {
				document.getElementById("logInButton").disabled = true;
			}
		}
		
		function isAllFilled() {
			var username = document.getElementById("username").value;
			var password = document.getElementById("password").value;
			
			if(username !== null && username !== ""
					&& password !== null && password !== "") {
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

	</script>
</body>
</html>