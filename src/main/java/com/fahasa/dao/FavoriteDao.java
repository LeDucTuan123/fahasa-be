package com.fahasa.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.fahasa.model.Favorite;
// import com.fahasa.model.Order;
import com.fahasa.model.OrderDetail;

public interface FavoriteDao extends JpaRepository<Favorite, Integer> {
	@Query("select d from Favorite d where d.user.id = ?1")
	List<OrderDetail> getFavoriteByUserId(Integer id);
	@Query("SELECT f.book FROM Favorite f WHERE f.user.id = :userId")
	List<Object[]> getBookInSuccess(@Param("userId") Integer id);
	@Query("SELECT f.schooltool FROM Favorite f WHERE f.user.id = :userId")
	List<Object[]> getSchoolToolInSuccess(@Param("userId") Integer id);
}
