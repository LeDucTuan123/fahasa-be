package com.fahasa.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.fahasa.model.MyVoucher;
@Repository
public interface MyVoucherDao extends JpaRepository<MyVoucher, Integer> {
	@Query("SELECT f FROM MyVoucher f WHERE f.user.id = :userId")
	List<Object[]> getMyVoucherInSuccess(@Param("userId") Integer id);

}
