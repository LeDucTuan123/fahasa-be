package com.fahasa.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fahasa.dao.VoucherDAO;
import com.fahasa.model.Voucher;
import com.fahasa.service.VoucherService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class VoucherServiceImpl implements VoucherService {
	
	@Autowired
	VoucherDAO vdao;

	@Override
	public List<Voucher> getVoucherStillValid() {
		return vdao.getVoucherStillValid(true);
	}

	@Override
	public List<Voucher> getAll() {
		// TODO Auto-generated method stub
		return vdao.findAll();
	}

	@Override
	public Voucher create(JsonNode voucher) {
		// TODO Auto-generated method stub
		System.out.println(voucher);
		ObjectMapper mapper = new ObjectMapper();
		Voucher v = mapper.convertValue(voucher, Voucher.class);
		vdao.save(v);
		return null;
	}

	@Override
	public void delete(Integer id) {
		// TODO Auto-generated method stub
		vdao.deleteById(id);
	}

	@Override
	public Voucher findById(Integer id) {
		// TODO Auto-generated method stub
		return vdao.findById(id).get();
	}

	@Override
	public Voucher update(Integer id, Voucher voucher) {
		// TODO Auto-generated method stub
		Voucher existingVoucher = vdao.findById(id).orElse(null);
		
		if(existingVoucher != null) {
			existingVoucher.setCode(voucher.getCode());
			existingVoucher.setExpdate(voucher.getExpdate());
			existingVoucher.setValuev(voucher.getValuev());
			existingVoucher.setCondition(voucher.getCondition());
			existingVoucher.setQuantity(voucher.getQuantity());
			existingVoucher.setOrders(voucher.getOrders());
			vdao.save(existingVoucher);
		}
		return existingVoucher;
	}

}
