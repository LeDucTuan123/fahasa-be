package com.fahasa.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fahasa.dao.MyVoucherDao;
import com.fahasa.model.MyVoucher;
import com.fahasa.service.MyVoucherService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class MyVoucherServiceImpl implements MyVoucherService {
	
	@Autowired
	MyVoucherDao mvdao;

	@Override
	public List<MyVoucher> getAll() {
		// TODO Auto-generated method stub
		return mvdao.findAll();
	}

    @Override
	public List<Object[]> getSuccessMyVoucher(Integer id) {
        List<Object[]> list = mvdao.getMyVoucherInSuccess(id);
		return list;
	}

	@Override
	public MyVoucher create(JsonNode myvoucher) {
		// TODO Auto-generated method stub
		System.out.println(myvoucher);
		ObjectMapper mapper = new ObjectMapper();
		MyVoucher v = mapper.convertValue(myvoucher, MyVoucher.class);
		mvdao.save(v);
		return null;
	}
}
