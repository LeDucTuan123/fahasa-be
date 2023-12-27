package com.fahasa.service.impl;

import com.fahasa.dao.NotificationDAO;
import com.fahasa.model.Notification;
import com.fahasa.model.User;
import com.fahasa.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class NotificationServiceImpl implements NotificationService {

    @Autowired
    private NotificationDAO notificationDAO;

    @Override
    public List<Notification> getAll() {
        return notificationDAO.findAll();
    }

    @Override
    public Notification getNotificationById(Long id) {
        Optional<Notification> notification = notificationDAO.findById(id);
        return notification.orElse(null);
    }

    @Override
    public Notification create(Notification createdNotification) {
        // Kiểm tra và thiết lập user_email hoặc User tương ứng trong thông báo
        User user = createdNotification.getUser();
        if (user != null) {
            createdNotification.setUserEmail(user.getEmail());
        }

        // Tiếp tục tạo thông báo hoặc thực hiện các thao tác khác để thiết lập thông báo

        return notificationDAO.save(createdNotification);
    }

    @Override
    public Notification update(Notification updatedNotification) {
        Optional<Notification> existingNotificationOptional = notificationDAO.findById(updatedNotification.getId());

        if (existingNotificationOptional.isPresent()) {
            Notification existingNotification = existingNotificationOptional.get();
            existingNotification.setTitle(updatedNotification.getTitle());
            existingNotification.setContent(updatedNotification.getContent());

            // Cập nhật ngày thông báo (nếu cần thiết)
            existingNotification.setNotificationDate(new Date());

            return notificationDAO.save(existingNotification);
        } else {
            // Trả về null hoặc thực hiện xử lý thông báo khi không tìm thấy
            return null;
        }
    }

    @Override
    public void delete(Long id) {
        notificationDAO.deleteById(id);
    }
}
