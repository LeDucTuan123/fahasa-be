package com.fahasa.dao;

import com.fahasa.model.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface NotificationDAO extends JpaRepository<Notification, Long> {

    List<Object[]> findNotificationByUserId(@Param("userId") Integer userId);

    List<Notification> findByTypeNotifyId(Long typeNotifyId);
}
