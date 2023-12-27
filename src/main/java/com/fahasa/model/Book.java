package com.fahasa.model;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Books")
public class Book implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String title;
    private String author;
    private Double price;
    private Integer discount;
    private String description;
    private String images;
    @JsonManagedReference(value = "cat-book")
    @OneToMany(mappedBy = "book", cascade = CascadeType.ALL)
    List<Cat> cats;
    @JsonBackReference(value = "book-product")
    @ManyToOne
    @JoinColumn(name = "productid")
    Product product;
    @JsonManagedReference(value = "orderdetail-book")
    @OneToMany(mappedBy = "book")
    List<OrderDetail> orderdetails;
    @JsonManagedReference(value = "favorite-book")
    @OneToMany(mappedBy = "book")
    List<Favorite> favorite;
    @JsonManagedReference(value = "review-book")
    @OneToMany(mappedBy = "book")
    List<Review> reviews;
}