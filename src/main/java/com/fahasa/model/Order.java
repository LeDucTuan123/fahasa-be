package com.fahasa.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Orders")
public class Order implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Temporal(TemporalType.TIMESTAMP)
	private Date orderdate;
	private Double totalamount;	
	private String receiver;
	private Double ship;
	private String codeorder;
	@JsonBackReference(value = "order-user")
	@ManyToOne
	@JoinColumn(name = "userid")
	User user;
	@OneToOne
	@JoinColumn(name = "statussid")
	Statuss statuss;
	@JsonBackReference(value = "order-voucher")
	@ManyToOne
	@JoinColumn(name = "voucherid")
	Voucher voucher;
	@JsonBackReference(value = "order-myvoucher")
	@ManyToOne
	@JoinColumn(name = "myvoucherid")
	MyVoucher myvoucher;
	@JsonBackReference(value = "order-address")
	@ManyToOne
	@JoinColumn(name = "addressid")
	Address address;
	@JsonManagedReference(value = "orderdetail-order")
	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	List<OrderDetail> orderdetails;
}
