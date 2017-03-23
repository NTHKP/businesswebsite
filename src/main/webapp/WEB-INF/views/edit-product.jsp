<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit product</title>
</head>
<body>
<h1>Edit product</h1>
<form action="${pageContext.request.contextPath}/edit-product" method="post" enctype="multipart/form-data">
	<table>
			<tr>
				<td>Name:</td>
				<td>${editingProduct.productName}<input type="hidden" name="productName"
					value="${editingProduct.productName}" /></td>
			</tr>
			<tr>
				<td>Price:</td>
				<td><input type="number" name="productPrice" min="0" step="100" required="required"
					value="${editingProduct.productPrice}" /></td>
			</tr>
			<tr>
				<td>Quantity in stock:</td>
				<td><input type="number" name="productQuantityInStock" min="1" step="1" required="required"
					value="${editingProduct.productQuantityInStock}" /></td>
			</tr>
			<tr>
				<td>Current image:</td>
				<td><img src="${pageContext.request.contextPath}/get-product-image?productName=${editingProduct.productName}"
					alt="${editingProduct.productName}" width="180" height="180"></td>
			</tr>
			<tr>
				<td>New image:</td>
				<td><input type="file" name="productImageFile" required="required"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Edit Product" /></td>
			</tr>
		</table>
</form>
</body>
</html>