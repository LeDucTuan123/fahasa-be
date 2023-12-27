package com.fahasa.model;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Product")
public class Product implements Serializable {
	@Id
	Long id;
	String name;
	@JsonManagedReference(value = "book-product")
	@OneToMany(mappedBy = "product")
	List<Book> books;
	@JsonManagedReference(value = "schooltool-product")
	@OneToMany(mappedBy = "product")
	List<SchoolTool> schooltools;
}
