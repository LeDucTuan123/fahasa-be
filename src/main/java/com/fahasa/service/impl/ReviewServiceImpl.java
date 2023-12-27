package com.fahasa.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fahasa.dao.ReviewDAO;
import com.fahasa.model.Review;
import com.fahasa.service.ReviewService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	ReviewDAO dao;

	@Override
	public Review send(JsonNode data) {
		ObjectMapper mapper = new ObjectMapper();
		Review review = mapper.convertValue(data, Review.class);
		return dao.save(review);
	}

}
