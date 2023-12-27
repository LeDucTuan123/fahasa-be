package com.fahasa.RestController;

import com.fahasa.model.Address;
import com.fahasa.model.MyVoucher;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.fahasa.service.AddressService;

import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/user/rest/address")
public class AddressRestController {
	@Autowired
	AddressService addressService;

	@GetMapping
	public List<Address> getAllAddresses() {
		return addressService.getAll();
	}

	@GetMapping("/default/{id}")
	public List<Object[]> getDefaultAddress(@PathVariable("id") Integer id) {
		return addressService.getDefaultAddress(id);
	}

	@PostMapping("/create")
	public Address create(@RequestBody JsonNode address) {
		return addressService.create(address);
	}

	@PutMapping("/update/{id}")
	public ResponseEntity<Address> updateAddress(@PathVariable("id") Integer id, @RequestBody JsonNode updatedAddress) {
		Address existingAddress = addressService.findById(id);

		if (existingAddress != null) {
			ObjectMapper mapper = new ObjectMapper();
			Address updated = mapper.convertValue(updatedAddress, Address.class);
			updated.setId(existingAddress.getId());
			Address updatedAddressEntity = addressService.update(updated);

			return ResponseEntity.ok(updatedAddressEntity);
		} else {
			return ResponseEntity.notFound().build();
		}
	}

	@DeleteMapping("/delete/{id}")
	public void delete(@PathVariable("id") Integer id) {
		addressService.delete(id);
	}
}
