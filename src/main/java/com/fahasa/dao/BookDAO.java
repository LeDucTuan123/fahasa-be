package com.fahasa.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.fahasa.model.Book;

public interface BookDAO extends JpaRepository<Book, Integer> {
    List<Book> findByTitleContaining(String title);

    @Query("SELECT b FROM Book b " +
            "JOIN Cat c ON b.id = c.book.id " +
            "JOIN Category ca ON ca.id = c.category.id " +
            "WHERE ca.parent.id IN (SELECT caa.id FROM Category caa WHERE caa.parent.id = :id)")
    List<Book> findBooksByParentId(@Param("id") Integer id);

    @Query("SELECT b FROM Book b " +
            "JOIN Cat c ON b.id = c.book.id " +
            "JOIN Category ca ON ca.id = c.category.id " +
            "WHERE ca.parent.id = :id")
    List<Book> findBooksByParentId2(@Param("id") Integer id);

    @Query("SELECT b FROM Book b " +
            "JOIN Cat c ON b.id = c.book.id " +
            "JOIN Category ca ON ca.id = c.category.id " +
            "WHERE ca.id = :id")
    List<Book> findBooksByParentId3(@Param("id") Integer id);

}
