package com.fahasa.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.fahasa.model.Order;
import com.fahasa.model.Voucher;

public interface OrderDAO extends JpaRepository<Order, Integer>{
	@Query("select o from Order o where o.statuss.id = 1 and o.user.id = ?1")
	Order getOrderInCartByUser(Integer id);
	@Query("select o from Order o where o.statuss.id in (2, 3, 4) and o.user.id = ?1")
	List<Order> getOrderSuccess(Integer id);
	@Query("SELECT o.voucher FROM Order o WHERE o.id = ?1")
    Voucher findVoucherById(Integer orderId);
}
