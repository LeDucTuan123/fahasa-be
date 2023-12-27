package com.fahasa.RestController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fahasa.dao.MyVoucherDao;
import com.fahasa.model.MyVoucher;
import com.fahasa.service.MyVoucherService;
import com.fasterxml.jackson.databind.JsonNode;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/myvoucher")
public class MyVoucherRestController {
	
	@Autowired
	MyVoucherService service;
	
	// @Autowired
	// private MyVoucherDao voucherDAO;
	
	
	@GetMapping("/getall")
	public List<MyVoucher> main(){
		return service.getAll();
	}

     @GetMapping("/success/{id}")
    public List<Object[]> getProductInSuccessFavorite(@PathVariable("id") Integer id) {
     return service.getSuccessMyVoucher(id);
    }
	
	
	@PostMapping
	public MyVoucher create(@RequestBody JsonNode myvoucher) {
		return service.create(myvoucher);
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
