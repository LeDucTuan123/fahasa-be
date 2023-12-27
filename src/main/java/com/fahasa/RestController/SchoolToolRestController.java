package com.fahasa.RestController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.fahasa.dao.SchoolToolDAO;
import com.fahasa.model.SchoolTool;
import com.fahasa.service.SchoolToolService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/schooltool")
public class SchoolToolRestController {

	@Autowired
	SchoolToolService service;
	@Autowired
	SchoolToolDAO Dao;

	@GetMapping
	public List<SchoolTool> getAll() {
		return service.getAll();
	}

	@GetMapping("/search")
	public List<SchoolTool> searchByName(@RequestParam String q) {
		return Dao.findByTitleContaining(q);
	}

	@GetMapping("{id}")
	public SchoolTool getProduct(@PathVariable("id") Integer id) {
		return service.findById(id);
	}

	@GetMapping("/cate2/{id}")
	public List<SchoolTool> findBooksByCate2(@PathVariable("id") Integer id) {
		return Dao.findToolsByParentId2(id);
	}

	@GetMapping("/cate3/{id}")
	public List<SchoolTool> findBooksByCate3(@PathVariable("id") Integer id) {
		return Dao.findToolsByParentId3(id);
	}

	@PostMapping(consumes={"application/json"})
	public SchoolTool create(@RequestBody SchoolTool schoolTool) {
		return service.create(schoolTool);
	}

	@PutMapping("{id}")
	public ResponseEntity<String> update(@PathVariable("id") Integer id, @RequestBody SchoolTool tool) {
		service.update(id,tool);
		return ResponseEntity.ok("Product updated successfully");
	}

	@DeleteMapping("{id}")
	public void delete(@PathVariable("id") Integer id) {
		service.delete(id);
	}

	@GetMapping("test")
	public List<Object[]> test(){
		return Dao.SchoolToolCate();
	}
}
