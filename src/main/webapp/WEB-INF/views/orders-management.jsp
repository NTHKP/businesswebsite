<%@ include file="template/header.jspf" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body onload="loadOrderStatusOptions(), setOrderStatusFormat()">
	<%@ include file="template/nav-bar.jspf" %>
	<div class="container">
		<h2>Orders Management</h2>
		
		<c:if test="${id != null && status != null}">
			<p class="text-primary"><em>You have changed the status of <span class="text-danger">Order Ref.: ${id}</span> to
						<span class="text-danger">${status}</span>.</em></p>
		</c:if>		
		
		<c:choose>
		<c:when test="${allOrders == null || allOrders.isEmpty() == true}">
			<div>
				<p class="text-primary"><em>No orders have been placed.</em></p>
			</div>
		</c:when>
		<c:otherwise>		
			<div class="row">
				<div class="col-md-2 text-left">
					<h4>Customer</h4>
				</div>
				<div class="col-md-4 text-left">
					<h4>Products</h4>
				</div>
				<div class="col-md-2 text-right">
					<h4>Order Date</h4>
				</div>
				<div class="col-md-2 text-right">
					<h4>Amount</h4>
				</div>
				<div class="col-md-2 text-right">
					<h4>Status</h4>
				</div>
			</div>
			<hr/>
			
			<c:forEach items="${allOrders}" var="order" varStatus="orderLoop">
			<form action="${pageContext.request.contextPath}/update-order-status" method="post">
				<div class="row">
					<div class="col-md-2">
						<p class="form-control-static text-danger"><strong>Order Ref.: ${order.orderId}</strong></p>
						<p class="form-control-static text-primary"><strong>${order.customerFirstName} ${order.customerLastName}</strong></p>
						<p><small>${order.customerEmail}</small></p>
					</div>
					<div class="col-md-4">
						<button type="button" class="btn btn-default" data-toggle="collapse"
								data-target="#orderDetails${orderLoop.index}">Details</button>
						<div id="orderDetails${orderLoop.index}" class="collapse">
							<table class="table">
								<thead>
									<tr>
										<th>Product</th>
										<th class="text-right">Unit Price</th>
										<th class="text-right">Quantity</th>
										<th class="text-right">Amount</th>
									<tr>
								</thead>
								<tbody>
									<c:forEach items="${order.productList}" var="product">
										<tr>
											<td>${product.productName}</td>
											<td align="right"><fmt:formatNumber pattern="#,###">${product.productPrice}</fmt:formatNumber></td>
											<td align="right"><fmt:formatNumber pattern="#,###">${product.productQuantity}</fmt:formatNumber></td>
											<td align="right"><fmt:formatNumber pattern="#,###">${product.totalAmount}</fmt:formatNumber></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="col-md-2 text-right">
						<p class="form-control-static">${order.orderDate}</p>
					</div>
					<div class="col-md-2 text-right">
						<p class="form-control-static">VND <span><fmt:formatNumber pattern="#,###">${order.totalAmount}</fmt:formatNumber></span></p>
					</div>
					<div class="col-md-2 text-right">
						<div class="hidden" style="float:right; margin:0; padding:0;">
							<select class="form-control" onchange="showUpdateButton(this)">
								<option>${order.orderStatus}</option>
								<option></option>
								<option></option>
							</select>
						</div>
						
						<div class="col-md-9" style="float:right; margin:0; padding:0;">
							<button type="button" name="orderStatusButton" class="" onclick="switchElement(this)"><span>${order.orderStatus}</span> <i></i></button>
						</div>
						
						<div class="hidden" style="float:right; margin-top:10px; padding:0;">
							<input type="hidden" name="orderId" value="${order.orderId}"/>
							<input type="hidden" name="orderStatus" value=""/>
							<input type="submit" class="btn btn-default btn-xs btn-block" value="Update"/>
						</div>
					</div>
				</div>
				<hr/>
			</form>
			</c:forEach>
		</c:otherwise>
		</c:choose>
	</div>
	
	<script type="text/javascript">
		function loadOrderStatusOptions() {
			var allSelectElements = document.getElementsByTagName("select");
			for(var i = 0; i < allSelectElements.length; i++) {
				var firstOptionElement = allSelectElements[i].children[0];
				var secondOptionElement = allSelectElements[i].children[1];
				var thirdOptionElement = allSelectElements[i].children[2];
				
				if(new String(firstOptionElement.innerHTML).valueOf() === new String("Processing").valueOf()){
					secondOptionElement.innerHTML = "In Transit";
					thirdOptionElement.innerHTML = "Delivered";
				} else if(new String(firstOptionElement.innerHTML).valueOf() === new String("In Transit").valueOf()) {
					secondOptionElement.innerHTML = "Processing";
					thirdOptionElement.innerHTML = "Delivered";
				} else {
					secondOptionElement.innerHTML = "Processing";
					thirdOptionElement.innerHTML = "In Transit";
				}
			}
		}
		
		function setOrderStatusFormat() {
			var elements = document.getElementsByName("orderStatusButton");
			for(var i = 0; i < elements.length; i++) {
				var spanChild = elements[i].children[0];
				var iChild = elements[i].children[1];
				if(new String(spanChild.innerHTML).valueOf() === new String("Processing").valueOf()) {
					elements[i].className = "btn btn-warning btn-block";
					iChild.className = "fa fa-refresh fa-spin";
				}
				if(new String(spanChild.innerHTML).valueOf() === new String("In Transit").valueOf()) {
					elements[i].className = "btn btn-info btn-block";
					iChild.className = "fa fa-truck";
				}
				if(new String(spanChild.innerHTML).valueOf() === new String("Delivered").valueOf()) {
					elements[i].className = "btn btn-success btn-block";
					iChild.className = "fa fa-check";
				}
			}
		}
		
		function switchElement(element) {
			element.parentElement.className = "hidden";
			element.parentElement.previousElementSibling.className = "col-md-9";
		}
		
		function showUpdateButton(element) {
			element.parentElement.nextElementSibling.nextElementSibling.className = "col-md-9";
			element.parentElement.nextElementSibling.nextElementSibling.children[1].value = element.value;
		}
	</script>

<%@ include file="template/footer.jspf" %>