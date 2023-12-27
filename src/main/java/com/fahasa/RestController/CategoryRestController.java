package com.fahasa.RestController;

import java.util.List;

import com.fahasa.model.Book;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.fahasa.model.Category;
import com.fahasa.service.CategoryService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/category")
public class CategoryRestController {
	
	@Autowired
	CategoryService service;
	
	@GetMapping()
	public List<Category> getAll() {
		return service.getAll();
	}

	@PostMapping()
	public void create(@RequestBody JsonNode category) {
		service.create(category);
	}

	@PutMapping("{id}")
	public ResponseEntity<String> update(@PathVariable("id") Integer id, @RequestBody Category category) {
		service.update(id,category);
		return ResponseEntity.ok("Product updated successfully");
	}


	@DeleteMapping("{id}")
	public void delete(@PathVariable("id") Integer id) {
		service.delete(id);
	}
}

