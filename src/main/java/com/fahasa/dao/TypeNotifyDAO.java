package com.fahasa.dao;

import com.fahasa.model.Notification;
import com.fahasa.model.TypeNotify;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TypeNotifyDAO extends JpaRepository<TypeNotify, Long> {

    List<TypeNotify> findByType(String type);

}
