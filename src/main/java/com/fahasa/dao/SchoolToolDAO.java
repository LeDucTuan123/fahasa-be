package com.fahasa.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.fahasa.model.SchoolTool;

public interface SchoolToolDAO extends JpaRepository<SchoolTool, Integer> {
    List<SchoolTool> findByTitleContaining(String title);

    @Query("SELECT s FROM SchoolTool s " +
            "JOIN Category ca ON s.category.id = ca.id " +
            "WHERE ca.parent.id = :id")
    List<SchoolTool> findToolsByParentId2(@Param("id") Integer id);

    @Query("SELECT s FROM SchoolTool s " +
            "WHERE s.category.id = :id")
    List<SchoolTool> findToolsByParentId3(@Param("id") Integer id);

    @Query("select s,s.category.id from SchoolTool s")
    List<Object[]> SchoolToolCate();
}
