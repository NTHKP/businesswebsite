<%@ include file="template/header.jspf" %>
</head>
<body onload="getActivePage()">
	<%@ include file="template/nav-bar.jspf" %>
	<div class="container">
		<c:forEach items="${orderedProducts}" var="orderedProduct" varStatus="loop">
			<div>
				<form action="${pageContext.request.contextPath}/remove-from-cart" method="post">
				<ul>
					<li>Name: <span>${orderedProduct.productName}</span> <input type="hidden" name="productName" value="${orderedProduct.productName}"/></li>
					<li>Price: VND <span><fmt:formatNumber pattern="#,###">${orderedProduct.productPrice}</fmt:formatNumber></span></li>
					<li>Quantity: <span>${orderedProduct.productQuantity}</span> <input type="hidden" name="productQuantity" value="${orderedProduct.productQuantity}"/></li>
					<li>Total: VND <span><fmt:formatNumber pattern="#,###">${orderedProduct.totalAmount}</fmt:formatNumber></span></li>
					<li><input type="submit" value="Remove from Cart" /></li>	
				</ul> 
				</form>
			</div>
		</c:forEach>
		<c:choose>
			<c:when test="${orderedProducts == null || orderedProducts.isEmpty() == true}">
				<div>
					<p>You have not added any products to Shopping Cart.</p>
				</div>
			</c:when>
			<c:otherwise>
				<div>
					<form action="/orders" method="post">
						<p>Total Amount: VND <span><fmt:formatNumber pattern="#,###">${totalShoppingCartAmount}</fmt:formatNumber></span>
							 <input type="submit" value="Confirm Order" /></p>
					</form>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<%@ include file="template/common-javascripts.jspf" %>
</body>
</html>