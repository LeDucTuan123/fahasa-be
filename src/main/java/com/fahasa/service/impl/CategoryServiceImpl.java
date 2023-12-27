package com.fahasa.service.impl;

import java.util.List;

import com.fahasa.model.Book;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fahasa.dao.CategoryDAO;
import com.fahasa.model.Category;
import com.fahasa.service.CategoryService;
@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	CategoryDAO cdao;
	
	@Override
	public List<Category> getAll() {
		return cdao.findAll();
	}

	@Override
	public Category create(JsonNode category) {
		System.out.println(category);
		ObjectMapper mapper = new ObjectMapper();
		Category c = mapper.convertValue(category, Category.class);
		cdao.save(c);
		return null;
	}

	@Override
	public Category update(Integer id, Category category) {
		Category existingProduct = cdao.findById(id).orElse(null);

		if (existingProduct != null) {
			existingProduct.setCategoryname(category.getCategoryname());
			existingProduct.setParent(category.getParent());
			cdao.save(existingProduct);
		} else {
			// Xử lý khi không tìm thấy sản phẩm với ID đã cho
			// Có thể ném một ngoại lệ hoặc thực hiện các hành động phù hợp khác
		}
		return existingProduct;
	}

	@Override
	public void delete(Integer id) {
		cdao.deleteById(id);
	}

}
