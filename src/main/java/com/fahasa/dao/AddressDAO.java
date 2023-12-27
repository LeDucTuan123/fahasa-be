package com.fahasa.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fahasa.model.Address;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AddressDAO extends JpaRepository<Address, Integer> {

    List<Object[]> findAddressesByUserId(@Param("userId") Integer userId);

    @Query("SELECT a FROM Address a WHERE a.user.id = :userId AND a.isactive = true")
    List<Address> findActiveAddressesByUserId(@Param("userId") Integer userId);
}
