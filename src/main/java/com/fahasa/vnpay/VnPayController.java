package com.fahasa.vnpay;

import java.io.UnsupportedEncodingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fahasa.model.Order;
import com.fahasa.service.OrderService;

@CrossOrigin("*")
@RestController
@RequestMapping("/payment")
public class VnPayController {
	
	@Autowired
	OrderService service;
	
	@Autowired
	VnPayService vnservice;
	
	@GetMapping("/vnpay/{id}")
	@ResponseBody
	public String doPayment(@PathVariable("id") Integer id) {
		Order o = service.findById(id);
		String payUrl = "";
		try {
			payUrl = vnservice.doPayment(o);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return payUrl;
		
	}
}
