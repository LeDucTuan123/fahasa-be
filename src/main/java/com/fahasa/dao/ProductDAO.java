package com.fahasa.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
// import org.springframework.data.jpa.repository.Query;

import com.fahasa.model.Product;

public interface ProductDAO extends JpaRepository<Product, Long> {

    List<Product> findByNameContaining(String title);

    // @Query("SELECT p FROM Product p WHERE" + "")

}
