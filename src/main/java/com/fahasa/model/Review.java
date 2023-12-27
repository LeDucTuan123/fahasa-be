package com.fahasa.model;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
@Table(name = "Reviews")
public class Review implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private Integer rating;
	private String comment;
	@Temporal(TemporalType.DATE)
	private Date createdate;
	private String username;
	@JsonBackReference(value = "review-book")
	@ManyToOne
	@JoinColumn(name = "bookid")
	Book book;
	@JsonBackReference(value = "review-user")
	@ManyToOne
	@JoinColumn(name = "userid")
	User user;
	@JsonBackReference(value = "review-schooltool")
	@ManyToOne
	@JoinColumn(name = "schooltoolid")
	SchoolTool schooltool;
	
}
