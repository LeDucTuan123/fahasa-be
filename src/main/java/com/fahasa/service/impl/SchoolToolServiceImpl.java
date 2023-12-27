package com.fahasa.service.impl;

import java.util.List;

import com.fahasa.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fahasa.dao.SchoolToolDAO;
import com.fahasa.model.SchoolTool;
import com.fahasa.service.SchoolToolService;

@Service
public class SchoolToolServiceImpl implements SchoolToolService {

	@Autowired
	SchoolToolDAO stdao;

	@Override
	public List<SchoolTool> getAll() {
		return stdao.findAll();
	}

	@Override
	public SchoolTool findById(Integer id) {
		return stdao.findById(id).get();
	}

	@Override
	public List<SchoolTool> findToolsByParentId2(Integer id) {
		return stdao.findToolsByParentId2(id);
	}

	@Override
	public List<SchoolTool> findToolsByParentId3(Integer id) {
		return stdao.findToolsByParentId3(id);
	}

	@Override
	public SchoolTool create(SchoolTool schoolTool) {
		return stdao.save(schoolTool);
	}

	@Override
	public SchoolTool update(Integer id, SchoolTool tool) {
		SchoolTool existingProduct = stdao.findById(id).orElse(null);

		if (existingProduct != null) {
			existingProduct.setTitle(tool.getTitle());
			existingProduct.setBrand(tool.getBrand());
			existingProduct.setImages(tool.getImages());
			existingProduct.setPrice(tool.getPrice());
			existingProduct.setDiscount(tool.getDiscount());
			existingProduct.setDescription(tool.getDescription());
			if (tool.getCategory() != null) {
				// Giả sử rằng lớp Category có một phương thức setCategoryId
				existingProduct.setCategory(tool.getCategory());
			} else {
				// Nếu bạn muốn đặt category là null, xử lý tương ứng
				existingProduct.setCategory(null);
			}
			stdao.save(existingProduct);
		} else {
			// Xử lý khi không tìm thấy sản phẩm với ID đã cho
			// Có thể ném một ngoại lệ hoặc thực hiện các hành động phù hợp khác
		}
		return existingProduct;
	}

	@Override
	public void delete(Integer id) {
		stdao.deleteById(id);
	}


}
