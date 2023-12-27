package com.fahasa.service;

import com.fahasa.model.Review;
import com.fasterxml.jackson.databind.JsonNode;

public interface ReviewService {

	Review send(JsonNode data);

}
