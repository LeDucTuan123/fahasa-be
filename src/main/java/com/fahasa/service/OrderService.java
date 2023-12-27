package com.fahasa.service;


import java.util.List;

import com.fahasa.model.Order;
import com.fasterxml.jackson.databind.JsonNode;

public interface OrderService {

	Order create(JsonNode order);

	List<Order> getAll();

	Order getOrderInCart(Integer id);

	Order payment(JsonNode data);

	List<Order> getOrderSuccess(Integer id);
	

	List<Order> getAllOrdersSuccess();
	
	Order getOrderById(Integer orderId);
	
	Order updateOrderStatus(Integer orderId, Integer statusId);

	Order findById(Integer id);

	void paymentSuccess(Integer id);

	Order delete(Integer id);

}
