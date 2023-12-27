package com.fahasa.service;

import java.util.List;

import com.fahasa.model.MyVoucher;
import com.fasterxml.jackson.databind.JsonNode;

public interface MyVoucherService {
	
	List<MyVoucher> getAll();
	
	MyVoucher create(JsonNode voucher);

    List<Object[]> getSuccessMyVoucher(Integer id);

	

}
