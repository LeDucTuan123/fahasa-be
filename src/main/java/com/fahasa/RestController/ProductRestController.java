package com.fahasa.RestController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fahasa.dao.ProductDAO;
import com.fahasa.model.Product;
import com.fahasa.service.ProductService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/product")
public class ProductRestController {
	
	@Autowired
	ProductService service;
	@Autowired
	private ProductDAO ProductDAO;

	@GetMapping
	public List<Product> getAll() {
		return service.getAll();
	}

	@GetMapping("/search")
    public List<Product> searchByName(@RequestParam String q,String t) {
        return ProductDAO.findByNameContaining(q);
    }
}
