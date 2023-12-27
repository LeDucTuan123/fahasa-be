package com.fahasa.dao;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.fahasa.model.Cat;

public interface CatDao extends JpaRepository<Cat, Integer> {
    @Query("SELECT c.id AS catId, c.category.id AS categoryId FROM Cat c")
    List<Object[]> findAllCats();
}

