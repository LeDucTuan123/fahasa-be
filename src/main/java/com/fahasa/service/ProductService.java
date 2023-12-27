package com.fahasa.service;


import java.util.List;

import com.fahasa.model.Product;

public interface ProductService {

	List<Product> getAll();

	// Product find(String title);
	// List<Product> findByNameContaining(String title);
}