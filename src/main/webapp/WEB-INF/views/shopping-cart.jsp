<%@ include file="template/header.jspf" %>
<style>
	div.row p {
		font-size: 24px;
	}
</style>
</head>
<body onload="getActivePage()">
	<%@ include file="template/nav-bar.jspf" %>
	<div class="container">
		<h2>Shopping Cart</h2>
		<c:if test="${addedPrd != null && addedQty != null}">
			<p class="text-primary"><em>You have added <span class="text-danger"><strong>${addedQty} ${addedPrd}</strong>
					</span> to Shopping Cart.</em></p>
		</c:if>
		<c:if test="${rmvPrd != null && rmvQty != null}">
			<p class="text-primary"><em>You have removed <span class="text-danger"><strong>${rmvQty} ${rmvPrd}</strong>
					</span> from Shopping Cart.</em></p>
		</c:if>
		<c:choose>
		<c:when test="${orderedProducts == null || orderedProducts.isEmpty() == true}">
			<div>
				<p class="text-primary"><em>You have not added any products to Shopping Cart.</em></p>
			</div>
		</c:when>
		<c:otherwise>		
			<div class="row">
				<div class="col-md-8 text-right">
					<h5>Price</h5>
				</div>
				<div class="col-md-2 text-right">
					<h5>Quantity</h5>
				</div>
				<div class="col-md-2 text-right">
					<h5>Amount</h5>
				</div>
			</div>
			<hr/>
			
			<c:forEach items="${orderedProducts}" var="orderedProduct" varStatus="loop">
			<form action="${pageContext.request.contextPath}/remove-from-cart" method="post">
				<div class="row">
					<div class="col-md-2">
						<img src="${pageContext.request.contextPath}/get-product-image?productName=${orderedProduct.productName}"
								alt="${orderedProduct.productName}" width="100%" height="auto">
					</div>
					<div class="col-md-4">
						<p>${orderedProduct.productName}</p>
						<input type="hidden" name="productName" value="${orderedProduct.productName}"/>
						<input type="submit" class="btn btn-danger btn-xs" value="Remove from Cart"/>
					</div>
					<div class="col-md-2 text-right">
						<p>VND <span><fmt:formatNumber pattern="#,###">${orderedProduct.productPrice}</fmt:formatNumber></span></p>
					</div>
					<div class="col-md-2 text-right">
						<div class="col-md-6"></div>
						<div class="col-md-6" style="padding:0;">
							<input type="number" class="form-control input-sm text-right" name="productQuantity"
									min="1" value="${orderedProduct.productQuantity}" onchange="showButton(this)"/>
						</div>
						<div class="col-md-6"></div>
						<div class="col-md-6" style="padding:0; margin-top:10px;">
							<button class="hidden" type="submit"
									formaction="${pageContext.request.contextPath}/update-cart" formmethod="post"
									>Update</button>
						</div>
					</div>
					<div class="col-md-2 text-right">
						<p>VND <span><fmt:formatNumber pattern="#,###">${orderedProduct.totalAmount}</fmt:formatNumber></span></p>
					</div>
				</div>
				<hr/>
			</form>
			</c:forEach>
			
			<div class="row">
				<div class="col-md-12 text-right">					
					<p><strong>Total: </strong><strong class="text-primary">VND <span><fmt:formatNumber pattern="#,###">${totalShoppingCartAmount}
								</fmt:formatNumber></span></strong></p>
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
								Confirm Order</button>					
				</div>
			</div>
			
			<!-- Modal -->
			<form action="${pageContext.request.contextPath}/orders" method="post">
			<div id="myModal" class="modal fade">
				<div class="modal-dialog">
			
			    	<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h2 class="modal-title">Customer's Information</h2>
			    		</div>
			      		<div class="modal-body">
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
			      		</div>
			      		<div class="modal-footer">
			        		<button type="submit" id="submitButton" class="btn btn-primary">Submit</button>
			      		</div>
			    	</div>			
			  	</div>
			</div>
			</form>

		</c:otherwise>
		</c:choose>
	</div>
		
	<%@ include file="template/common-javascripts.jspf" %>
	<script type="text/javascript">
		function showButton(button) {
			button.parentElement.nextElementSibling.nextElementSibling.firstElementChild.className =
					"btn btn-primary btn-xs btn-block";
		}
		
		function enableSubmitButton() {
			if(document.getElementsByClassName("glyphicon-remove")[0] == null && isAllFilled()) {
				document.getElementById("submitButton").disabled = false;
			} else {
				document.getElementById("submitButton").disabled = true;
			}
		}
		
		function isAllFilled() {
			var firstName = document.getElementById("firstName").value;
			var lastName = document.getElementById("lastName").value;
			var email = document.getElementById("email").value;
			if(firstName !== null && firstName !== ""
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