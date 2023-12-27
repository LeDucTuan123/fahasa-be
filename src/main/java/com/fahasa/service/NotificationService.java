package com.fahasa.service;

import com.fahasa.model.Notification;

import java.util.List;

public interface NotificationService {
    List<Notification> getAll();

    Notification getNotificationById(Long id);

    Notification create(Notification createdNotification);

    Notification update(Notification updatedNotification);

    void delete(Long id);
}
