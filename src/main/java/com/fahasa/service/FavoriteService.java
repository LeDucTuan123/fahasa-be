package com.fahasa.service;


import java.util.List;

import org.springframework.stereotype.Service;

import com.fahasa.model.Favorite;
import com.fasterxml.jackson.databind.JsonNode;

@Service
public interface FavoriteService {

    List<Favorite> getAll();
    
    Favorite create(JsonNode Favorite);
    
    List<Object[]> getProductInSuccessFavorite(Integer id);

    void delete(Integer id);

}
