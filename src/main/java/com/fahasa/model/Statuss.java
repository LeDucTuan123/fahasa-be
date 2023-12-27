package com.fahasa.model;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Statuss")
public class Statuss implements Serializable {
	@Id
	Integer id;
	String statuss;
	@JsonIgnore
	@OneToOne(mappedBy = "statuss")
	Order order;
}
