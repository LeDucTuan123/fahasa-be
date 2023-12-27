package com.fahasa.service;

import java.util.List;

import com.fahasa.model.Voucher;
import com.fasterxml.jackson.databind.JsonNode;

public interface VoucherService {

	List<Voucher> getVoucherStillValid();
	
	List<Voucher> getAll();
	
	Voucher create(JsonNode voucher);
	
	void delete(Integer id);
	
	Voucher findById(Integer id);

	Voucher update(Integer id, Voucher voucher);

}
