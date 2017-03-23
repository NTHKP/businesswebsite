package com.hieu.businesswebsite.dao;

import java.util.List;

public interface GenericDao<T> {
	
	List<T> getAll();
	void create(T t);
	T get(T t);
	T update (T t);
	void delete(T t);
}
