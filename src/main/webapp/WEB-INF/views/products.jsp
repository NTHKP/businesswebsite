<%@ include file="template/header.jspf" %>
</head>
<body onload="getActivePagination(${pageNum}), getActivePage()">
	<%@ include file="template/nav-bar.jspf" %>
	
	<div class="container">	
		<h2>Products</h2>		
		<div class="row">	
			<div class="col-md-8">
				<form class="form-inline" action="${pageContext.request.contextPath}/products" method="get">
					<p class="form-control-static">Specify number of products displayed per page:</p>			
					<input type="number" class="form-control text-right" name="numProductsPerPage" min="1" step="1"
							value="${numProductsPerPage}"/>						
					<button class="btn btn-default" type="submit">Submit</button>					
				</form>
			</div>
		</div>
	</div>
	
	<div class="container" style="margin-top:30px;">
		<div class="row">
			<c:forEach items="${productsList}" var="product" varStatus="loop">
				<div class="col-md-4">
					<form action="${pageContext.request.contextPath}/shopping-cart" method="post">
					<div class="panel panel-info">
						<div class="panel-heading">
							<p><strong><span id="nameId${loop.index}">${product.productName}</span> <input type="hidden" name="productName" value="${product.productName}"/></strong></p>
						</div>
						<div class="panel-body">
							<img src=<%-- "${pageContext.request.contextPath}/get-product-image?productName=${product.productName}" --%>"data:image/jpeg;base64,${product.productImageBase64}"
											alt="${product.productName}" width="100%" height="auto">
						</div>
						<div class="panel-footer">
							<ul class="list-unstyled">	
								<li>Price: VND <span id="priceId${loop.index}"><fmt:formatNumber pattern="#,###">${product.productPrice}</fmt:formatNumber></span></li>
								<li class="form-inline">Quantity: <input class="form-control" id="quantityId${loop.index}" type="number" name="productQuantity" value="1" min="1" step="1" onchange="getTotal(${loop.index})"/></li>
								<li>Total: VND <span id="totalId${loop.index}"><fmt:formatNumber pattern="#,###">${product.productPrice}</fmt:formatNumber></span></li>
								<security:authorize access="!hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
									<li class="text-danger">Please <a href="${pageContext.request.contextPath}/login">log in</a> to purchase.</li>
								</security:authorize>
								<security:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
									<li><input class="btn btn-primary" type="submit" value="Add to Cart" />
										<security:authorize access="hasAnyRole('ROLE_ADMIN')">
											<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal"
													onclick="setProductDataToModal(${loop.index})">Edit Product</button>
										</security:authorize>
									</li>
								</security:authorize>								
							</ul> 
						</div>						
					</div>
						
					</form>
				</div>
			</c:forEach>
		</div>
		
		<!-- Modal -->
		<form action="${pageContext.request.contextPath}/edit-product" method="post" enctype="multipart/form-data">
		<div id="myModal" class="modal fade">
			<div class="modal-dialog">
		
		    	<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h2 class="modal-title">Edit Product</h2>
		    		</div>
		      		<div class="modal-body">
		        		<div class="form-group has-feedback">
							<label class="control-label" for="name">Name:</label>
							<div class="input-group">
				    			<span class="input-group-addon"><i class="glyphicon glyphicon-tags"></i></span>
							  	<input type="text" class="form-control" id="name" required="required"
							  			disabled="disabled" onchange="checkNotNull('name'), enableSubmitButton()"/>
							  	<input type="hidden" id="hiddenName" name="name" value=""/>	
							</div>		
							<span></span>
						</div>
						<div class="form-group has-feedback">
							<label class="control-label" for="price">Price:</label>
						  	<div class="input-group">
				    			<span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
							  	<input type="number" min="0" step="100"class="form-control" id="price" name="price" 
							  			required="required" onchange="checkNotNull('price'), enableSubmitButton()"/>				
							</div>
							<span></span>
						</div>
						<div class="form-group has-feedback">
							<label class="control-label" for="quantity">Quantity in stock:</label>
						  	<div class="input-group">
				    			<span class="input-group-addon"><i class="glyphicon glyphicon-list-alt"></i></span>
							  	<input type="number" min="1" step="1" class="form-control" id="quantity" name="quantity" 
							  			required="required" onchange="checkNotNull('quantity'), enableSubmitButton()" />				
							</div>
							<span></span>
						</div>
						<div class="form-group has-feedback">
							<label class="control-label" for="image">Image:</label>
						  	<input type="file" id="image" name="image" required="required"
							  		onchange="enableSubmitButton()" />				
							<span></span>
						</div>
		      		</div>
		      		<div class="modal-footer">
		        		<button type="submit" id="submitButton" class="btn btn-primary" disabled="disabled">Submit</button>
		      		</div>
		    	</div>			
		  	</div>
		</div>
		</form>
		
		<div class="text-center">
			<ul class="pagination">
				<c:choose>
					<c:when test="${pageNum <= 1}">
						<li><a href="${pageContext.request.contextPath}/products?pageNum=${pageNum}">Previous</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${pageContext.request.contextPath}/products?pageNum=${pageNum-1}">Previous</a></li>
					</c:otherwise>
				</c:choose>
				
				<c:forEach var="i" begin="1" end="${numberOfPages}" varStatus="paginationNum">
					<li id="pagination${paginationNum.index}"><a href="${pageContext.request.contextPath}/products?pageNum=${i}">${i}</a></li>		
				</c:forEach>
				
				<c:choose>
					<c:when test="${pageNum >= numberOfPages}">
						<li><a href="${pageContext.request.contextPath}/products?pageNum=${pageNum}">Next</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${pageContext.request.contextPath}/products?pageNum=${pageNum+1}">Next</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
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
			var name = document.getElementById("name").value;
			var price = document.getElementById("price").value;
			var quantity = document.getElementById("quantity").value;
			var image = document.getElementById("image").files.length;
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
		
		function getTotal(id) {
			var price = document.getElementById("priceId" + id).innerHTML;
			var quantity = document.getElementById("quantityId" + id).value;
			var total = parseInt(price.toString().replace(/,/g, "")) * parseInt(quantity.toString().replace(/,/g, ""));
			document.getElementById("totalId"+id).innerHTML = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		function getActivePagination(pageNum) {
			document.getElementById("pagination" + pageNum).className = "active";
		}
		
		function setProductDataToModal(index) {		
			document.getElementById("name").value = document.getElementById("nameId" + index).innerHTML;
			document.getElementById("hiddenName").value = document.getElementById("nameId" + index).innerHTML;
		}
	</script>
	<%@ include file="template/common-javascripts.jspf" %>
	
<%@ include file="template/footer.jspf" %>