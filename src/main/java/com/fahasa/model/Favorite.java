 package com.fahasa.model;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Favorite")
public class Favorite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @JsonBackReference(value = "favorite-user")
    @ManyToOne
    @JoinColumn(name = "userid")  // Đặt tên cột theo tên trong cơ sở dữ liệu
    private User user;

    @JsonBackReference(value = "favorite-book")
    @ManyToOne
    @JoinColumn(name = "bookid")  // Đặt tên cột theo tên trong cơ sở dữ liệu
    private Book book;

    @JsonBackReference(value = "favorite-schooltool")
    @ManyToOne
    @JoinColumn(name = "schooltoolid")  // Đặt tên cột theo tên trong cơ sở dữ liệu
    private SchoolTool schooltool;

    
}

   
