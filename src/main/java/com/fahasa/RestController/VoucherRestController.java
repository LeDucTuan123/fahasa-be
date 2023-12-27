package com.fahasa.RestController;

import java.util.List;

import org.hibernate.annotations.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fahasa.dao.VoucherDAO;
import com.fahasa.model.Voucher;
import com.fahasa.service.VoucherService;
import com.fasterxml.jackson.databind.JsonNode;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/voucher")
public class VoucherRestController {
	
	@Autowired
	VoucherService service;
	
	@Autowired
	private VoucherDAO voucherDAO;
	
	@GetMapping
	public List<Voucher> getVouchersStillValid() {
		return service.getVoucherStillValid();
	}
	
	@GetMapping("/getAll")
	public List<Voucher> main(){
		return service.getAll();
	}
	
	@GetMapping("{id}")
	public Voucher getVoucher(@PathVariable("id") int id) {
		return service.findById(id);
	}
	
	@PostMapping
	public Voucher create(@RequestBody JsonNode voucher) {
		return service.create(voucher);
	}
	
	@PutMapping("{id}")
	public ResponseEntity<String> update(@PathVariable("id") Integer id, @RequestBody Voucher voucher) {
		service.update(id,voucher);
		return ResponseEntity.ok("Product updated successfully");
	}
	
	@DeleteMapping("{id}")
	public void delete(@PathVariable("id") int id) {
		service.delete(id);
	}
	
	public ResponseEntity<String> yourEndpoint(@RequestBody String requestBody, HttpServletRequest request, HttpServletResponse response) {
		// Lấy giá trị của header 'Content-Type' từ yêu cầu
		String contentType = request.getHeader("Content-Type");
		
		// Lấy giá trị của header 'Accept' từ yêu cầu
		String acceptHeader = request.getHeader("Accept");
		
		// Xử lý logic của bạn dựa trên giá trị của các headers
		// ...
		
		// Trả về phản hồi cho client
		String responseBody = "Your response message";
		return ResponseEntity.status(HttpStatus.OK)
		.contentType(MediaType.APPLICATION_JSON)
		.body(responseBody);
	}
}
