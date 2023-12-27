package com.fahasa.RestController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fahasa.model.Review;
import com.fahasa.service.ReviewService;
import com.fasterxml.jackson.databind.JsonNode;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/review")
public class ReviewRestController {
	@Autowired
	ReviewService service;
	
	@PostMapping("/send")
	public Review send(@RequestBody JsonNode data) {
		return service.send(data);
	}
	
}
