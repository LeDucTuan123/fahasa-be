package com.fahasa.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.fahasa.model.Voucher;
@Repository
public interface VoucherDAO extends JpaRepository<Voucher, Integer> {
	@Query("select v from Voucher v where v.expdate > CURRENT_DATE and v.active = ?1 order by v.condition asc")
	List<Voucher> getVoucherStillValid(Boolean active);
}
