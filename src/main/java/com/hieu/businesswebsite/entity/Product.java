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
	
	@Lob
	@Column(nullable=false)
	private byte[] productImage;

	public Product() {}
	
	public Product(String productName, int productPrice, int productQuantityInStock, byte[] productImage) {
		super();
		this.productName = productName;
		this.productPrice = productPrice;
		this.productQuantityInStock = productQuantityInStock;
		this.productImage = productImage;
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

	public byte[] getProductImage() {
		return productImage;
	}

	public void setProductImage(byte[] productImage) {
		this.productImage = productImage;
	}

}
