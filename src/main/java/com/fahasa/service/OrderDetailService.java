package com.fahasa.service;

import java.util.List;

import com.fahasa.model.OrderDetail;
import com.fasterxml.jackson.databind.JsonNode;

public interface OrderDetailService {

	OrderDetail updateQuantity(JsonNode data);

	OrderDetail delete(Integer id);

	List<Object[]> getProductInSuccessOrder(Integer id);

	List<OrderDetail> getAll();

}
