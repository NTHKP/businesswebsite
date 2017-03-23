<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>Add products</title>
</head>
<body>
<h1>Add products</h1>
<p style="color:red;">${duplicateProduct}</p>
<p style="color:blue;">${productAdded}</p>
<form action="${pageContext.request.contextPath}/add-products" method="post" enctype="multipart/form-data">
	<table>
			<tr>
				<td>Name:</td>
				<td><input type="text" name="productName" required="required" /></td>
			</tr>
			<tr>
				<td>Price:</td>
				<td><input type="number" name="productPrice" min="0" step="100" required="required" /></td>
			</tr>
			<tr>
				<td>Quantity in stock:</td>
				<td><input type="number" name="productQuantityInStock" min="1" step="1" required="required" /></td>
			</tr>
			<tr>
				<td>Image:</td>
				<td><input type="file" name="productImageFile" required="required"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Add to Stock" /></td>
			</tr>
		</table>
</form>
</body>
</html>