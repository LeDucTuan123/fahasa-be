package com.fahasa.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fahasa.model.Category;

public interface CategoryDAO extends JpaRepository<Category, Integer> {

}
