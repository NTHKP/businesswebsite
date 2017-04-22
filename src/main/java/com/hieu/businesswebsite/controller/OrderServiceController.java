package com.hieu.businesswebsite.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.hieu.businesswebsite.entity.Order;
import com.hieu.businesswebsite.entity.OrderedProduct;
import com.hieu.businesswebsite.entity.Product;
import com.hieu.businesswebsite.service.OrderService;

@Controller
public class OrderServiceController {
	
	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value="/products", method=RequestMethod.GET)
	public String showProductsPage(@RequestParam(required=false) Integer pageNum,
								@RequestParam(required=false) Integer numProductsPerPage,
								HttpServletRequest request) {
		
		if(pageNum == null || pageNum < 1) {
			pageNum = 1;
		}		
		if(numProductsPerPage == null) {
			if(request.getSession().getAttribute("numProductsPerPage") != null) {
				numProductsPerPage = (Integer) request.getSession().getAttribute("numProductsPerPage");
			} else {
				numProductsPerPage = 3;
			}
		}
		
		request.getSession().setAttribute("numProductsPerPage", numProductsPerPage);
		request.getSession().setAttribute("numberOfPages", orderService.calculatePagination(numProductsPerPage));
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("productsList", orderService.getAllProductsPagination(pageNum, numProductsPerPage));
		return "products";
	}
	
	@RequestMapping(value="/add-products", method=RequestMethod.GET)
	public String showAddProductsPage() {
		return "add-products";
	}
	
	@RequestMapping(value="/add-products", method=RequestMethod.POST)
	public String addProducts(@RequestParam String productName, @RequestParam int productPrice,
					@RequestParam int productQuantityInStock, @RequestParam CommonsMultipartFile productImageFile,
					HttpServletRequest request) {
	
		if(!orderService.checkIfProductIsNotDuplicate(productName)) {
			request.setAttribute("duplicateProduct", "Product already exists in stock.");
			return "add-products";
		}
		
		String productImageBase64 = Base64.getEncoder().encodeToString(productImageFile.getBytes());		
		Product product = new Product(productName, productPrice, productQuantityInStock, productImageBase64);
		orderService.addProduct(product);
		request.setAttribute("productAdded", "Product has been added successfully!");
		return "add-products";
	}
	
	@RequestMapping(value="/edit-product", method=RequestMethod.GET)
	public String showEditProductPage(@RequestParam String productName, HttpServletRequest request) {
		Product product = orderService.getProductByName(productName);
		request.setAttribute("editingProduct", product);
		return "edit-product";
	}
	
	@RequestMapping(value="/edit-product", method=RequestMethod.POST)
	public String editProduct(@RequestParam String name, @RequestParam int price,
			@RequestParam int quantity, @RequestParam CommonsMultipartFile image) {
		
		String productImageBase64 = Base64.getEncoder().encodeToString(image.getBytes());
		
		Product product = new Product(name, price, quantity, productImageBase64);
		orderService.updateProduct(product);
		return "redirect:products";
	}
	
	@RequestMapping(value="/shopping-cart", method=RequestMethod.GET)
	public String showShoppingCart(@RequestParam(required=false) String product,
								@RequestParam(required=false) String quantity,
								@RequestParam(required=false) String rmvPrd,
								@RequestParam(required=false) String rmvQty,
								HttpServletRequest request) {
		
		if(product != null && !product.trim().equals("")
				&& quantity != null && !quantity.trim().equals("")) {
			request.setAttribute("addedPrd", product);
			request.setAttribute("addedQty", quantity);
		}
		
		if(rmvPrd != null && !rmvPrd.trim().equals("")
				&& rmvQty != null && !rmvQty.trim().equals("")) {
			request.setAttribute("rmvPrd", rmvPrd);
			request.setAttribute("rmvQty", rmvQty);
		}
		
		return "shopping-cart";
	}
	
	@RequestMapping(value="/shopping-cart", method=RequestMethod.POST)
	public String addToCart(@RequestParam String productName, @RequestParam int productQuantity,
							HttpServletRequest request) {
		Product product = orderService.getProductByName(productName);
		
		OrderedProduct orderedProduct = new OrderedProduct();
		orderedProduct.setProductName(product.getProductName());
		orderedProduct.setProductPrice(product.getProductPrice());
		orderedProduct.setProductQuantity(productQuantity);
		orderedProduct.setTotalAmount();
		orderedProduct.setProductImageBase64(product.getProductImageBase64());
		
		int totalShoppingCartAmount = 0;
		List<OrderedProduct> orderedProducts = null;
		if(request.getSession().getAttribute("orderedProducts") == null) {
			orderedProducts = new ArrayList<OrderedProduct>();
		} else {
			orderedProducts = (List<OrderedProduct>) request.getSession().getAttribute("orderedProducts");
			totalShoppingCartAmount = (Integer) request.getSession().getAttribute("totalShoppingCartAmount");
		}
		
		boolean isDuplicateProduct = false;
		for(OrderedProduct op : orderedProducts) {
			if(op.getProductName().equals(orderedProduct.getProductName())) {
				isDuplicateProduct = true;
				int newQuantity = op.getProductQuantity() + orderedProduct.getProductQuantity();
				op.setProductQuantity(newQuantity);
				op.setTotalAmount();
			}
		}
		
		if(!isDuplicateProduct) {
			orderedProducts.add(orderedProduct);
		} 
		
		totalShoppingCartAmount += orderedProduct.getTotalAmount();
		
		request.getSession().setAttribute("orderedProducts", orderedProducts);
		request.getSession().setAttribute("totalShoppingCartAmount", totalShoppingCartAmount);
		
		return "redirect:shopping-cart?product=" + orderedProduct.getProductName() + "&quantity=" + orderedProduct.getProductQuantity();
		
	}
	
	@RequestMapping(value="/remove-from-cart", method=RequestMethod.POST)
	public String removeFromCart(@RequestParam String productName, @RequestParam int productQuantity,
							HttpServletRequest request) {
		List<OrderedProduct> orderedProducts = (List<OrderedProduct>) request.getSession().getAttribute("orderedProducts");
		List<OrderedProduct> removedProducts = new ArrayList<OrderedProduct>();
		int totalShoppingCartAmount = (Integer) request.getSession().getAttribute("totalShoppingCartAmount");
		for(OrderedProduct product : orderedProducts) {
			if(product.getProductName().equals(productName) && product.getProductQuantity() == productQuantity) {
				removedProducts.add(product);
				totalShoppingCartAmount -= product.getTotalAmount();
				break;
			}
		}
		orderedProducts.removeAll(removedProducts);
		request.getSession().setAttribute("orderedProducts", orderedProducts);
		request.getSession().setAttribute("totalShoppingCartAmount", totalShoppingCartAmount);
		return "redirect:shopping-cart?rmvPrd=" + removedProducts.get(0).getProductName() + 
				"&rmvQty=" + removedProducts.get(0).getProductQuantity();
	}
	
	@RequestMapping(value="/update-cart", method=RequestMethod.POST)
	public String updateCart(@RequestParam String productName, @RequestParam int productQuantity,
					HttpServletRequest request) {
		List<OrderedProduct> orderedProducts = (List<OrderedProduct>) request.getSession().getAttribute("orderedProducts");
		for(OrderedProduct op : orderedProducts) {
			if(op.getProductName().equals(productName)) {
				op.setProductQuantity(productQuantity);
				op.setTotalAmount();
			}
		}
		
		int totalShoppingCartAmount = 0;
		for(OrderedProduct op : orderedProducts) {
			totalShoppingCartAmount += op.getTotalAmount();
		}
		
		request.getSession().setAttribute("orderedProducts", orderedProducts);
		request.getSession().setAttribute("totalShoppingCartAmount", totalShoppingCartAmount);
		
		return "redirect:shopping-cart";
	}
	
	/*@RequestMapping(value="/get-product-image", method=RequestMethod.GET)
	public void getProductImage(@RequestParam String productName, HttpServletResponse response) throws IOException {
		Product product = orderService.getProductByName(productName);
		response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
		response.getOutputStream().write(product.getProductImageBase64());
		response.getOutputStream().close();
	}*/
	
	@RequestMapping(value="/orders", method=RequestMethod.GET)
	public String showOrdersPage(@RequestParam(required=false) String orderRef, HttpServletRequest request) {
		
		if(orderRef != null && !orderRef.trim().equals("")) {
			request.setAttribute("orderRef", "Thank you for placing an order with us. Your order reference is: " + orderRef + ".");
		}
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails currentUser = null;
		if(principal instanceof UserDetails) {
			currentUser = (UserDetails) principal;
		}
		List<Order> orders = orderService.getAllOrdersByUsername(currentUser.getUsername());
		
		/*List<Order> processingOrders = new ArrayList<Order>();
		List<Order> inTransitOrders = new ArrayList<Order>();
		List<Order> deliveredOrders = new ArrayList<Order>();
		for(Order order : orders) {
			if(order.getOrderStatus().equals("Processing")) {
				processingOrders.add(order);
			}
			if(order.getOrderStatus().equals("In Transit")) {
				inTransitOrders.add(order);
			}
			if(order.getOrderStatus().equals("Delivered")) {
				deliveredOrders.add(order);
			}
		}

		request.setAttribute("processingOrders", processingOrders);
		request.setAttribute("inTransitOrders", inTransitOrders);
		request.setAttribute("deliveredOrders", deliveredOrders);*/
		request.setAttribute("orderList", orders);
		
		return "orders";
	}
	
	@RequestMapping(value="/orders", method=RequestMethod.POST)
	public String addOrder(@RequestParam String firstName,
							@RequestParam String lastName,
							@RequestParam String email,
							HttpServletRequest request) {
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails currentUser = null;
		if(principal instanceof UserDetails) {
			currentUser = (UserDetails) principal;
		}
		
		Order order = new Order();
		order.setProductList((List<OrderedProduct>) request.getSession().getAttribute("orderedProducts"));
		order.setTotalAmount((Integer) request.getSession().getAttribute("totalShoppingCartAmount"));
		order.setOrderDate(new Date());
		order.setOrderStatus("Processing");
		order.setCustomerFirstName(firstName);
		order.setCustomerLastName(lastName);
		order.setCustomerEmail(email);
		
		orderService.createOrder(currentUser.getUsername(), order);
		
		request.getSession().setAttribute("orderedProducts", null);
		request.getSession().setAttribute("totalShoppingCartAmount", null);
		
		return "redirect:orders?orderRef=" + order.getOrderId();
	}
	
	@RequestMapping(value="/orders-management", method=RequestMethod.GET)
	public String showOrdersManagement(@RequestParam(required=false) String id,
								@RequestParam(required=false) String status,
								HttpServletRequest request) {
		
		if(id != null && !id.trim().equals("")
				&& status != null && !status.trim().equals("")) {
			request.setAttribute("id", id);
			request.setAttribute("status", status);
		}
		
		request.setAttribute("allOrders", orderService.getAllOrders());
		return "orders-management";
	}
	
	@RequestMapping(value="/orders-management", method=RequestMethod.POST)
	public String ordersManagement() {
		return "orders-management";
	}
	
	@RequestMapping(value="/update-order-status", method=RequestMethod.POST)
	public String updateOrderStatus(@RequestParam int orderId, @RequestParam String orderStatus) {
		
		orderService.updateOrder(orderId, orderStatus);
		return "redirect:orders-management?id=" + orderId + "&status=" + orderStatus;
	}
}
