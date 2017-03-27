<%@ include file="template/header.jspf" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>

</style>
</head>
<body onload="getActivePage(), setOrderStatusFormat()">
	<%@ include file="template/nav-bar.jspf" %>
	<div class="container">
		<h2>My orders</h2>
		<p class="text-primary"><em>${orderRef}</em></p>
		<c:if test="${orderList == null || orderList.isEmpty() == true}">
			<p class="text-primary"><em>You have not placed any orders with us.</em></p>
		</c:if>		
		<div class="row">
			<c:forEach items="${orderList}" var="order" varStatus="orderDetailsLoop">
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<p><strong>Order Ref.: <span>${order.orderId}</span></strong></p>
					</div>
					<div class="panel-body">
						<p>Order Date: <span>${order.orderDate}</span></p>
						<p>Order Status: <span name="orderStatus"><span>${order.orderStatus}</span> <i></i></span></p>
						<p>Order Amount: <strong>VND <span><fmt:formatNumber pattern="#,###">${order.totalAmount}
								</fmt:formatNumber></span></strong> <button type="button" class="btn btn-default" data-toggle="collapse"
								data-target="#orderDetails${orderDetailsLoop.index}">Details</button></p>
						
						<div id="orderDetails${orderDetailsLoop.index}" class="collapse">
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
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
		
	<script type="text/javascript">
		function setOrderStatusFormat() {
			var spanParents = document.getElementsByName("orderStatus");
			for(var i = 0; i < spanParents.length; i++) {
				var spanChild = spanParents[i].children[0];
				var iChild = spanParents[i].children[1];
				if(new String(spanChild.innerHTML).valueOf() === new String("Processing").valueOf()) {
					spanParents[i].className = "label label-warning";
					iChild.className = "fa fa-refresh fa-spin";
				}
				if(new String(spanChild.innerHTML).valueOf() === new String("In Transit").valueOf()) {
					spanParents[i].className = "label label-info";
					iChild.className = "fa fa-truck";
				}
				if(new String(spanChild.innerHTML).valueOf() === new String("Delivered").valueOf()) {
					spanParents[i].className = "label label-success";
					iChild.className = "fa fa-check";
				}
			}
		}
	</script>
	<%@ include file="template/common-javascripts.jspf" %>
<%@ include file="template/footer.jspf" %>