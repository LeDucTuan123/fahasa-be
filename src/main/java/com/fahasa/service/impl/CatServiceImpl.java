package com.fahasa.service.impl;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fahasa.dao.CatDao;
import com.fahasa.model.Cat;
import com.fahasa.service.CatService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class CatServiceImpl implements CatService{
    @Autowired
    CatDao CDao;
     @Override
    public List<Cat> getAll() {
        return CDao.findAll();
    }

    @Override
	public Cat create(JsonNode cat) {
		System.out.println(cat);
		ObjectMapper mapper = new ObjectMapper();
		Cat b = mapper.convertValue(cat, Cat.class);
		CDao.save(b);
		return null;
	}

    // @Override
    // public List<Cat> findAll() {
    //     // TODO Auto-generated method stub
    //     throw new UnsupportedOperationException("Unimplemented method 'findAll'");
    // }

    @Override
	public List<Object[]> findAll() {
		List<Object[]> list = CDao.findAllCats();
		// List<Object[]> list1 = fdao.getSchoolToolInSuccess(id);
		list.addAll(list);
		return list;
	}
    
}
