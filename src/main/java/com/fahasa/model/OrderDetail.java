package com.fahasa.model;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonBackReference;

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
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Orderdetails")
public class OrderDetail implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private Integer quantity;
	private Double price;
	@JsonBackReference(value = "orderdetail-order")
	@ManyToOne
	@JoinColumn(name = "orderid")
	Order order;
	@JsonBackReference(value = "orderdetail-book")
	@ManyToOne
	@JoinColumn(name = "bookid")
	Book book;
	@JsonBackReference(value = "orderdetail-schooltool")
	@ManyToOne
	@JoinColumn(name = "schooltoolid")
	SchoolTool schooltool;
}
