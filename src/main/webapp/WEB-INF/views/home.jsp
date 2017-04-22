<%@ include file="template/header.jspf" %>
</head>
<body onload="getActivePage()">
	<%@ include file="template/nav-bar.jspf" %>
	<div class="container">
		<security:authorize access="!hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
			<h2>Welcome, <strong>Guest</strong>.</h2>
			<p>If you already have an account, please <a href="${pageContext.request.contextPath}/login">log in</a> to
				access this website's features. Or you can <a href="${pageContext.request.contextPath}/signup">sign 
				up an account here</a>.</p>
			<p>You may use the following credentials to access an Admin account:</p>
			<ul>
				<li>Username: <strong class="text-danger">hieu</strong>.</li>
				<li>Password: <strong class="text-danger">ABCabc123!</strong>.</li>
			</ul>
		</security:authorize>
		<security:authorize access="hasAnyRole('ROLE_USER') && !hasAnyRole('ROLE_ADMIN')">
			<h2>Welcome back, <strong>${user.username}</strong>.</h2>
			<p>You can now access this website's features.</p>
			<p>You may use the following credentials to access an Admin account:</p>
			<ul>
				<li>Username: <strong class="text-danger">hieu</strong>.</li>
				<li>Password: <strong class="text-danger">ABCabc123!</strong>.</li>
			</ul>
		</security:authorize>
		<security:authorize access="hasAnyRole('ROLE_ADMIN')">
			<h2>Welcome back, <strong>${user.username}</strong>.</h2>
			<p>You are an admin of this website. You may access this website's advanced features.</p>
		</security:authorize>
	</div>
	<div class="container">
		<form class="form-inline" action="${pageContext.request.contextPath}" method="post">
			<p class="form-control-static">Specify city name to display weather:</p>			
			<input type="text" class="form-control" name="cityName" />						
			<button class="btn btn-default" type="submit">Submit</button>					
		</form>
		<c:if test="${outCityName != null}">
			<p>City Name: <span>${outCityName}</span></p>
			<p>Weather: <span>${outWeather}</span></p>
			<p>Wind Speed: <span>${outWind}</span></p>
			<p>Temperature: <span>${outTemp}</span></p>
		</c:if>
	</div>
	<div class="container">
		<h2>Tutorial</h2>
		<h3>Guests</h3>
		<p>Guests may access the most basic features of the website, such as browsing the 
			<a href="${pageContext.request.contextPath}/products">Products</a> page, but cannot make 
			any purchase. Guests can also <a href="${pageContext.request.contextPath}/login">log in</a>, or
			<a href="${pageContext.request.contextPath}/signup">sign up</a> an account.</p>
		<h3>Users</h3>
		<p>Users are those who have registered an account on this website. A User can:</p>
		<ul>
			<li>Access <a href="${pageContext.request.contextPath}/products">Products</a> page and make purchases.</li>
			<li>Access <a href="${pageContext.request.contextPath}/shopping-cart">Shopping Cart</a> to verify purchases.</li>
			<li>Access <a href="${pageContext.request.contextPath}/orders">My Orders</a> to check orders and their statuses.</li>
			<li>Edit <a href="${pageContext.request.contextPath}/account">Account Info</a>.</li>
		</ul>
		<h3>Admins</h3>
		<p>Admins are special users of this website who are granted special privileges and access to this website's
			advanced features.</p>
		<p>An Admin possesses all the accesses a User has:</p>
		<ul>
			<li>Access <a href="${pageContext.request.contextPath}/products">Products</a> page and make purchases.</li>
			<li>Access <a href="${pageContext.request.contextPath}/shopping-cart">Shopping Cart</a> to verify purchases.</li>
			<li>Access <a href="${pageContext.request.contextPath}/orders">My Orders</a> to check orders and their statuses.</li>
			<li>Edit <a href="${pageContext.request.contextPath}/account">Account Info</a>.</li>
		</ul>
		<p>and some extra privileges:</p>
		<ul>
			<li>Access <a href="${pageContext.request.contextPath}/add-products">Add Products</a> page to add more products.</li>
			<li>Access <a href="${pageContext.request.contextPath}/orders-management">Orders Management</a> page to manage orders.</li>
			<li>Edit any products in <a href="${pageContext.request.contextPath}/products">Products</a> page.</li>
		</ul>
	</div>
	
	<%@ include file="template/common-javascripts.jspf" %>
<%@ include file="template/footer.jspf" %>