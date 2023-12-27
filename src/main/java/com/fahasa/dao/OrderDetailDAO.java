package com.fahasa.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.fahasa.model.OrderDetail;

public interface OrderDetailDAO extends JpaRepository<OrderDetail, Integer> {
	@Query("select d from OrderDetail d where d.order.id = ?1")
	List<OrderDetail> getOrderDetailByOrderId(Integer id);
	@Query("select d.book, d.quantity, d.price from OrderDetail d where d.order.id = ?1")
	List<Object[]> getBookInSuccessOrder(Integer id);
	@Query("select d.schooltool, d.quantity, d.price from OrderDetail d where d.order.id = ?1")
	List<Object[]> getSchoolToolInSuccessOrder(Integer id);
	@Modifying
	@Query("delete from OrderDetail od where od.id = ?1")
	void deleteOrderDetailById(Integer id);
}
