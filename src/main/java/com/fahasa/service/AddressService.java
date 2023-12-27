package com.fahasa.service;

import com.fahasa.model.Address;
import com.fasterxml.jackson.databind.JsonNode;

import java.util.List;

public interface AddressService {

    List<Address> getAll();

    Address create(JsonNode address);

    List<Object[]> getDefaultAddress(Integer id);

    Address findById(Integer id);

    Address update(Address updatedAddress);

    void delete(Integer id);
}
