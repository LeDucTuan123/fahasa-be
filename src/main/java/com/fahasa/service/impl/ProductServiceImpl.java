package com.fahasa.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fahasa.dao.ProductDAO;
import com.fahasa.model.Product;
import com.fahasa.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDAO pdao;

	@Override
	public List<Product> getAll() {
		return pdao.findAll();
	}

	// @Override
	// public List<Product> findByNameContaining(String title) {
	// // TODO Auto-generated method stub
	// return pdao.find
	// }

	// @Override
	// public Product find(String title) {
	// return pdao.findAll(title).get();
	// }
}
