package com.hieu.businesswebsite.service;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.hieu.businesswebsite.entity.Order;
import com.hieu.businesswebsite.entity.Product;
import com.hieu.businesswebsite.entity.User;

@Service
@Transactional
public class OrderService {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	@Autowired
	private UserService userService;
	
	public List<Product> getAllProducts() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Product.class);
		return criteria.list();
	}
	
	public List<Product> getAllProductsPagination(int pageNum, int numProductsPerPage) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Product.class);
		criteria.setFirstResult((pageNum - 1) * numProductsPerPage);
		criteria.setMaxResults(numProductsPerPage);
		return criteria.list();
	}
	
	public int calculatePagination(int numProductsPerPage) {
		int numberOfPages = 0;
		int numberOfProducts = this.getAllProducts().size();
		if(numberOfProducts % numProductsPerPage == 0) {
			numberOfPages = numberOfProducts / numProductsPerPage;
		} else {
			numberOfPages = numberOfProducts / numProductsPerPage + 1;
		}
		return numberOfPages;
	}
	
	public void addProduct(Product product) {
		sessionFactory.getCurrentSession().persist(product);
	}
	
	public void updateProduct(Product product) {
		Product updatingProduct = this.getProductByName(product.getProductName());
		updatingProduct.setProductPrice(product.getProductPrice());
		updatingProduct.setProductQuantityInStock(product.getProductQuantityInStock());
		updatingProduct.setProductImageBase64(product.getProductImageBase64());
		sessionFactory.getCurrentSession().update(updatingProduct);
	}
	
	public boolean checkIfProductIsNotDuplicate(String productName) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Product.class);
		criteria.add(Restrictions.eq("productName", productName));
		return criteria.uniqueResult() == null;
	}
	
	public Product getProductByName(String productName) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Product.class);
		criteria.add(Restrictions.eq("productName", productName));
		return (Product) criteria.uniqueResult();
	}
	
	public void createOrder(String username, Order order) {
		User user = userService.getUserByUsername(username);
		user.getOrders().add(order);
		sessionFactory.getCurrentSession().update(user);
	}
	
	public List<Order> getAllOrdersByUsername(String username) {
		User user = userService.getUserByUsername(username);
		Hibernate.initialize(user.getOrders());
		return user.getOrders();
	}

	public List<Order> getAllOrders() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Order.class);
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
		return criteria.list();
	}
	
	public Order getOrderByOrderId(int orderId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Order.class);
		criteria.add(Restrictions.eq("orderId", orderId));
		return (Order) criteria.uniqueResult();
	}
	
	public void updateOrder(int orderId, String orderStatus) {
		Order order = this.getOrderByOrderId(orderId);
		order.setOrderStatus(orderStatus);
		sessionFactory.getCurrentSession().update(order);
	}
}
