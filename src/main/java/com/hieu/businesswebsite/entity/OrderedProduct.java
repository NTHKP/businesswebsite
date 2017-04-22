package com.hieu.businesswebsite.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="ordered_products")
public class OrderedProduct {
	@Id @GeneratedValue
	private int productId;
	private String productName;
	private int productQuantity;
	private int productPrice;
	private int totalAmount;
	@Column(nullable=false, columnDefinition="text")
	private String productImageBase64;
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductQuantity() {
		return productQuantity;
	}
	public void setProductQuantity(int productQuantity) {
		this.productQuantity = productQuantity;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public int getTotalAmount() {
		return totalAmount;
	}
	
	//Different setter
	public void setTotalAmount() {
		this.totalAmount = getProductPrice() * getProductQuantity();
	}
	public String getProductImageBase64() {
		return productImageBase64;
	}
	public void setProductImageBase64(String productImageBase64) {
		this.productImageBase64 = productImageBase64;
	}
	
	
	
}
