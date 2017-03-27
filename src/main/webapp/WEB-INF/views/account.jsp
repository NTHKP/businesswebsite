<%@ include file="template/header.jspf" %>
</head>
<body onload="getActivePage()">
	<%@ include file="template/nav-bar.jspf" %>
	
	<div class="container" style="width:40%;">
		<h2 class="text-center">Edit My Account Information</h2>
		<p class="text-danger"><em>${emailExists}</em></p>	
		<p class="text-danger"><em>${wrongPassword}</em></p>	
		<p class="text-primary"><em>${editSuccessful}</em></p>	
		<form action="${pageContext.request.contextPath}/account" method="post">
			<input type="hidden" name="username" value="${user.username}" />
			<div class="form-group has-feedback">
				<label class="control-label" for="firstName">First Name:</label>
				<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
				  	<input type="text" class="form-control" id="firstName" name="firstName" required="required"
				  			value="${user.firstName}" onchange="checkNotNull('firstName'), enableSubmitButton()"/>		
				</div>		
				<span></span>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="lastName">Last Name:</label>
			  	<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
				  	<input type="text" class="form-control" id="lastName" name="lastName" required="required"
				  			value="${user.lastName}" onchange="checkNotNull('lastName'), enableSubmitButton()"/>				
				</div>
				<span></span>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="email">Email:</label>
			  	<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
				  	<input type="text" class="form-control" id="email" name="email" required="required"
				  			pattern="[^@]+@[^@]+\.[a-zA-Z]{2,6}" onchange="emailValidation(), enableSubmitButton()"
				  			value="${user.email}" />				
				</div>
				<span></span>
				<div id="emailNotValid" class="hidden">
					<p><small>Please enter a valid email.</small></p>
				</div>
			</div>
			<div class="checkbox">
		        <label><input type="checkbox" onchange="checkbox(this)" id="checkb"> Change Password</label>
		    </div>
			<div class="hidden">
				<label class="control-label" for="oldPassword">Old Password:</label>
				<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
				  	<input type="password" class="form-control" id="oldPassword" name="oldPassword"
				  			onchange="checkNotNull('oldPassword'), enableSubmitButton()" placeholder="Enter your old password"/>
				</div>				
				<span></span>
			</div>
			<div class="hidden">
				<label class="control-label" for="password">New Password:</label>
				<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
				  	<input type="password" class="form-control" id="password" name="password"
				  			onchange="passwordValidation(), checkConfirmPassword(), enableSubmitButton()"
				  			pattern="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
				  			placeholder="Enter your new password"/>
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
			<div class="hidden">
				<label class="control-label" for="confirm">Confirm New Password:</label>
			  	<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
				  	<input type="password" class="form-control" id="confirm" name="confirmPassword"
				  			pattern="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
				  			onchange="checkConfirmPassword(), enableSubmitButton()"
				  			placeholder="Confirm your new password"/>
				</div>
				<span></span>
				<div id="cfmNotValid" class="hidden">
					<p><small>Password and Confirm Password does not match.</small></p>
				</div>
			</div>
			
			<button id="submitButton" type="submit" class="btn btn-block btn-primary">Submit</button>
		</form>
	</div>
	
	<%@ include file="template/common-javascripts.jspf" %>
	
	<script type="text/javascript">
		
		function checkbox(element) {
			if(element.checked) {
				document.getElementById("oldPassword").parentElement.parentElement.className = "form-group has-feedback";
				document.getElementById("password").parentElement.parentElement.className = "form-group has-feedback";
				document.getElementById("confirm").parentElement.parentElement.className = "form-group has-feedback";
				enableSubmitButton();
			} else {
				document.getElementById("oldPassword").parentElement.parentElement.className = "hidden";
				document.getElementById("password").parentElement.parentElement.className = "hidden";
				document.getElementById("confirm").parentElement.parentElement.className = "hidden";
				enableSubmitButton();
			}
		}
	 
		function enableSubmitButton() {
			if(document.getElementsByClassName("glyphicon-remove")[0] == null && isAllFilled()) {
				document.getElementById("submitButton").disabled = false;
			} else {
				document.getElementById("submitButton").disabled = true;
			}
		}
		
		function isAllFilled() {
			var oldPassword = document.getElementById("oldPassword").value;
			var password = document.getElementById("password").value;
			var confirm = document.getElementById("confirm").value;
			var firstName = document.getElementById("firstName").value;
			var lastName = document.getElementById("lastName").value;
			var email = document.getElementById("email").value;
			
			if(document.getElementById("checkb").checked) {
				if(oldPassword !== null && oldPassword !== ""
						&& password !== null && password !== ""
						&& confirm !== null && confirm !== ""
						&& firstName !== null && firstName !== ""
						&& lastName !== null && lastName !== ""
						&& email !== null && email !== "") {
					return true;
				} else {
					return false;
				} 
			} else {
				if(firstName !== null && firstName !== ""
						&& lastName !== null && lastName !== ""
						&& email !== null && email !== "") {
					return true;
				} else {
					return false;
				}
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
<%@ include file="template/footer.jspf" %>