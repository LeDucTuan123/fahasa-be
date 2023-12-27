package com.fahasa.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fahasa.model.Review;

public interface ReviewDAO extends JpaRepository<Review, Integer> {

}
