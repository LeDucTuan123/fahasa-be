package com.fahasa.service;

import java.util.List;

import com.fahasa.model.Book;
import com.fahasa.model.SchoolTool;

public interface SchoolToolService {

	List<SchoolTool> getAll();

	SchoolTool findById(Integer id);

	List<SchoolTool> findToolsByParentId2(Integer id);

	List<SchoolTool> findToolsByParentId3(Integer id);

	SchoolTool create(SchoolTool schoolTool);

	SchoolTool update(Integer id, SchoolTool tool);

	void delete(Integer id);
}
