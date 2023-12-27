package com.fahasa.service;

import java.util.List;

import com.fahasa.model.Category;
import com.fasterxml.jackson.databind.JsonNode;

public interface CategoryService {

	List<Category> getAll();

	Category create(JsonNode category);

	Category update(Integer id, Category category );

	void delete(Integer id);
}
