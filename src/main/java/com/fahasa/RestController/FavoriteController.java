package com.fahasa.RestController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fahasa.dao.FavoriteDao;
import com.fahasa.model.Favorite;
import com.fahasa.model.Order;
import com.fahasa.model.OrderDetail;
import com.fahasa.service.FavoriteService;
import com.fahasa.service.OrderDetailService;
import com.fasterxml.jackson.databind.JsonNode;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/favorite")
public class FavoriteController {
    @Autowired
    FavoriteService service;
    @Autowired
    FavoriteDao Dao;
    
    @GetMapping()
    public List<Favorite> getAll() {
        return service.getAll();
    }
    
    @PostMapping()
    public Favorite create(@RequestBody JsonNode favorite) {
        return service.create(favorite);
    }
    @GetMapping("/success/{id}")
    public List<Object[]> getProductInSuccessFavorite(@PathVariable("id") Integer id) {
     return service.getProductInSuccessFavorite(id);
    }

    @DeleteMapping("{id}")
	public void delete(@PathVariable("id") Integer id) {
		service.delete(id);
	}
    
}