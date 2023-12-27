package com.fahasa.model;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

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
@Table(name = "Categories")
public class Category implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String categoryname;
	private Integer level;
	private String images;
	@JsonManagedReference(value = "cat-category")
	@OneToMany(mappedBy = "category")
	List<Cat> cats;
	@JsonManagedReference(value = "schooltool-category")
	@OneToMany(mappedBy = "category")
	List<SchoolTool> schooltools;
	@ManyToOne
	@JoinColumn(name = "parentid")
	Category parent;
	@OneToMany(mappedBy = "category")
	List<SchoolTool> schoolTools;

}
