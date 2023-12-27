package com.fahasa.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
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
@Table(name = "Myvoucher")
public class MyVoucher implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;
    String title;
	String code;
	@Temporal(TemporalType.DATE)
	Date expdate;
	Double valuev;
	// Double condition;
	Boolean active;
	Integer quantity;
	@JsonManagedReference(value = "order-myvoucher")
	@OneToMany(mappedBy = "myvoucher")
	List<Order> orders;
    @JsonBackReference(value = "myvoucher-user")
    @ManyToOne
    @JoinColumn(name = "userid")  // Đặt tên cột theo tên trong cơ sở dữ liệu
    private User user;
}
