package com.hieu.businesswebsite.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

@Entity
@Table(name="products")
public class Product {
	
	@Id @GeneratedValue
	private int productId;
	
	@Column(nullable=false, unique=true)
	private String productName;
	
	@Column(nullable=false)
	private int productPrice;
	
	@Column(nullable=false)
	private int productQuantityInStock;
	
	@Column(nullable=false, columnDefinition="text")
	private String productImageBase64;

	public Product() {}
	
	public Product(String productName, int productPrice, int productQuantityInStock, String productImageBase64) {
		super();
		this.productName = productName;
		this.productPrice = productPrice;
		this.productQuantityInStock = productQuantityInStock;
		this.productImageBase64 = productImageBase64;
	}

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

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getProductQuantityInStock() {
		return productQuantityInStock;
	}

	public void setProductQuantityInStock(int productQuantityInStock) {
		this.productQuantityInStock = productQuantityInStock;
	}

	public String getProductImageBase64() {
		return productImageBase64;
	}

	public void setProductImageBase64(String productImageBase64) {
		this.productImageBase64 = productImageBase64;
	}



}
