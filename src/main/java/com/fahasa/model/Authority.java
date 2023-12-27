//package com.fahasa.model;
//
//import java.io.Serializable;
//
//import com.fasterxml.jackson.annotation.JsonBackReference;
//
//import jakarta.persistence.Entity;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
//import jakarta.persistence.Id;
//import jakarta.persistence.JoinColumn;
//import jakarta.persistence.ManyToOne;
//import jakarta.persistence.Table;
//import lombok.AllArgsConstructor;
//import lombok.Data;
//import lombok.NoArgsConstructor;
//
//
//@Data
//@NoArgsConstructor
//@AllArgsConstructor
//@Entity
//@Table(name = "Authorities")
//public class Authority implements Serializable{
//	@Id
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	private Integer id;
//	@JsonBackReference(value = "authority-user")
//	@ManyToOne
//	@JoinColumn(name = "userid")
//	User user;
//	@JsonBackReference(value = "authority-role")
//	@ManyToOne
//	@JoinColumn(name = "roleid")
//	Role role;
//
//}
//
