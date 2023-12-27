package com.fahasa.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fahasa.dao.FavoriteDao;
import com.fahasa.dao.OrderDAO;
import com.fahasa.dao.OrderDetailDAO;
import com.fahasa.model.Category;
import com.fahasa.model.Favorite;
import com.fahasa.model.Order;
import com.fahasa.model.OrderDetail;
import com.fahasa.service.FavoriteService;
import com.fahasa.service.OrderService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
@Service
public class FavoriteServiceImpl implements FavoriteService {
    
    @Autowired
    FavoriteDao fdao;
    
    // @Autowired
    // OrderDetailDAO ddao;

        @Override
    public Favorite create(JsonNode favorite) {
        System.out.println(favorite);
        ObjectMapper mapper = new ObjectMapper();
        Favorite c = mapper.convertValue(favorite, Favorite.class);
        fdao.save(c);
        return null;
    }

    @Override
    public List<Favorite> getAll() {
        return fdao.findAll();
    }

    @Override
	public List<Object[]> getProductInSuccessFavorite(Integer id) {
		List<Object[]> list = fdao.getBookInSuccess(id);
		List<Object[]> list1 = fdao.getSchoolToolInSuccess(id);
		list.addAll(list1);
		return list;
	}

    @Override
	public void delete(Integer id) {
		fdao.deleteById(id);
	}

    // @Override
    // public Order getOrderInCart(Integer id) {
    //  Order o = odao.getOrderInCartByUser(id);
    //  return o;
    // }

    // @Override
    // public Order payment(JsonNode data) {
    //  List<OrderDetail> orderdetails = new ArrayList<OrderDetail>();
    //  ObjectMapper mapper = new ObjectMapper();
    //  Order order = mapper.convertValue(data, Order.class);
    //  order.setOrderdetails(orderdetails);
    //  Order o = odao.save(order);
    //  TypeReference<List<OrderDetail>> type = new TypeReference<List<OrderDetail>>() {};
    //  List<OrderDetail> list = mapper.convertValue(data.get("orderdetails"), type);
    //  for(OrderDetail od : list) {
    //      od.setOrder(o);
    //      ddao.save(od);
    //  }
    //  return o;
    // }

    // @Override
    // public List<Order> getOrderSuccess(Integer id) {
    //  return odao.getOrderSuccess(id);
    // }

}
