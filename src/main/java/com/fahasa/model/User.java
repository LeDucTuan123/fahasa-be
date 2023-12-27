package com.fahasa.model;

import java.util.Collection;
import java.util.List;

import jakarta.persistence.*;

import lombok.Data;
import org.hibernate.annotations.NaturalId;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;


@Data
@Table(name = "Users")
@Entity
public class User implements UserDetails {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String phone;
	@NaturalId(mutable = true)
	private String email;
	private String password;
	@Enumerated(EnumType.STRING)
	private Role role;
	private String firstname;
	private String lastname;
	private String gender;
	private String birthday;
	@JsonManagedReference(value = "address-user")
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	List<Address> listAddress;
	@JsonManagedReference(value = "review-user")
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	List<Review> reviews;
	@JsonManagedReference(value = "notification-user")
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	List<Notification> notifications;
	public User( String phone, String email, String password, Role role, String firstname, String lastname, String gender, String birthday, List<Address> listAddress) {
		this.phone = phone;
		this.email = email;
		this.password = password;
		this.role = role;
		this.firstname = firstname;
		this.lastname = lastname;
		this.gender = gender;
		this.birthday = birthday;
		this.listAddress = listAddress;
	}

	public User() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}


	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	//	get role
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return List.of(new SimpleGrantedAuthority(role.name()));
	}

	@Override
	public String getUsername() {
		return email;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	public void setIdUsers(Integer id) {
	}
}
