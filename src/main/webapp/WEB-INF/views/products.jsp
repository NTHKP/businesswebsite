<%@ include file="template/header.jspf" %>
</head>
<body onload="getActivePagination(${pageNum}), getActivePage()">
	<%@ include file="template/nav-bar.jspf" %>
	
	<div class="container">			
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
							<p><strong><span>${product.productName}</span> <input type="hidden" name="productName" value="${product.productName}"/></strong></p>
						</div>
						<div class="panel-body">
							<img src="${pageContext.request.contextPath}/get-product-image?productName=${product.productName}" alt="${product.productName}"
											width="100%" height="auto">
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
											<input class="btn btn-danger" type="submit" value="Edit Product" formaction="${pageContext.request.contextPath}/edit-product" formmethod="get" />
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
		function getTotal(id) {
			var price = document.getElementById("priceId" + id).innerHTML;
			var quantity = document.getElementById("quantityId" + id).value;
			var total = parseInt(price.toString().replace(/,/g, "")) * parseInt(quantity.toString().replace(/,/g, ""));
			document.getElementById("totalId"+id).innerHTML = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		function getActivePagination(pageNum) {
			document.getElementById("pagination" + pageNum).className = "active";
		}
	</script>
	<%@ include file="template/common-javascripts.jspf" %>
	
</body>
</html>