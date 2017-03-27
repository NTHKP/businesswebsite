<%@ include file="template/header.jspf" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%@ include file="template/nav-bar.jspf" %>	
	<div class="container" style="width:40%;">
		<h2 class="text-center">Add Products</h2>
		<p class="text-primary"><em>${productAdded}</em></p>
		<p class="text-danger"><em>${duplicateProduct}</em></p>
		<form action="${pageContext.request.contextPath}/add-products" method="post" enctype="multipart/form-data">
			<div class="form-group has-feedback">
				<label class="control-label" for="productName">Product Name:</label>
				<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-tags"></i></span>
				  	<input type="text" class="form-control" id="productName" name="productName" required="required"
				  			placeholder="Enter product name" onchange="checkNotNull('productName'), enableSubmitButton()"/>		
				</div>
				<span></span>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="productPrice">Price:</label>
				<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
				  	<input type="number"  min="0" step="100" class="form-control" id="productPrice"
				  			name="productPrice" required="required" placeholder="Enter product price"
				  			onchange="checkNotNull('productPrice'), enableSubmitButton()" />
				</div>				
				<span></span>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="productQuantityInStock">Quantity in Stock:</label>
				<div class="input-group">
	    			<span class="input-group-addon"><i class="glyphicon glyphicon-list-alt"></i></span>
				  	<input type="number"  min="1" step="1" class="form-control" id="productQuantityInStock"
				  			name="productQuantityInStock" required="required" placeholder="Enter quantity in stock"
				  			onchange="checkNotNull('productQuantityInStock'), enableSubmitButton()" />
				</div>				
				<span></span>
			</div>
			<div class="form-group has-feedback">
					<label class="control-label" for="productImageFile">Image:</label>
					<input type="file" id="productImageFile" name="productImageFile" required="required"
									  onchange="enableSubmitButton()" />				
			</div>
			<button id="submitButton" type="submit" class="btn btn-block btn-primary" disabled="disabled">Add to Stock</button>
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
			var name = document.getElementById("productName").value;
			var price = document.getElementById("productPrice").value;
			var quantity = document.getElementById("productQuantityInStock").value;
			var image = document.getElementById("productImageFile").files.length;
			if(name !== null && name !== ""
					&& price !== null && price !== ""
					&& quantity !== null && quantity !== ""
					&& image !== 0) {
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
	
<%@ include file="template/footer.jspf" %>