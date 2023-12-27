package com.fahasa.service;
import java.util.List;

import com.fahasa.model.Cat;
import com.fasterxml.jackson.databind.JsonNode;

public interface CatService {
    List<Cat> getAll();

    Cat create(JsonNode cat);

    List<Object[]> findAll();

}


