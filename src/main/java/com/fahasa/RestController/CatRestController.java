package com.fahasa.RestController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fahasa.dao.CatDao;
import com.fahasa.model.Cat;
import com.fahasa.model.Category;
import com.fahasa.service.CatService;
import com.fahasa.service.CategoryService;
import com.fasterxml.jackson.databind.JsonNode;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/cat")
public class CatRestController {
    
   @Autowired
	CatService service;
    CatDao cdao;
	
	@GetMapping
	public List<Cat> getAll() {
		return service.getAll();
	}

	@GetMapping("/all")
	public List<Object[]> getAllCats() {
		return service.findAll();
	}
    
    @PostMapping()
	public void create(@RequestBody JsonNode cat) {
		service.create(cat);
	}
}
// :((