package com.fahasa.service.impl;

import com.fahasa.dao.AddressDAO;
import com.fahasa.model.Address;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fahasa.service.AddressService;

import java.util.List;

@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressDAO addressDAO;

    @Override
    public List<Address> getAll() {
        return addressDAO.findAll();
    }

    @Override
    public Address create(JsonNode address) {
        ObjectMapper mapper = new ObjectMapper();
        Address newAddress = mapper.convertValue(address, Address.class);

        if (newAddress.getIsactive()) {
            deactivateActiveAddressesForUser(newAddress.getUser().getId());
        }

        addressDAO.save(newAddress);
        return newAddress;
    }

    private void deactivateActiveAddressesForUser(Integer userId) {
        List<Address> activeAddresses = addressDAO.findActiveAddressesByUserId(userId);
        for (Address address : activeAddresses) {
            address.setIsactive(false);
            addressDAO.save(address);
        }
    }

    @Override
    public List<Object[]> getDefaultAddress(Integer id) {
        // Thực hiện công việc liên quan đến địa chỉ
        // (Nếu có)
        List<Object[]> list = addressDAO.findAddressesByUserId(id);
        return list;
    }

    @Override
    public Address findById(Integer id) {
        return addressDAO.findById(id).orElse(null);
    }

    @Override
    public Address update(Address updatedAddress) {

        if (updatedAddress.getIsactive()) {
            deactivateActiveAddressesForUser(updatedAddress.getUser().getId());
        }

        return addressDAO.save(updatedAddress);
    }

    @Override
    public void delete(Integer id) {
        addressDAO.deleteById(id);
    }
}
