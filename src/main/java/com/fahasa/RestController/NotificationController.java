package com.fahasa.RestController;

import com.fahasa.dao.MessageResponse;
import com.fahasa.dao.TypeNotifyDAO;
import com.fahasa.model.Notification;
import com.fahasa.model.TypeNotify;
import com.fahasa.model.User;
import com.fahasa.reponsitory.UserRepository;
import com.fahasa.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/notifications")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TypeNotifyDAO typeNotifyDAO;
    @GetMapping
    public ResponseEntity<List<Notification>> getAllNotifications() {
        List<Notification> notifications = notificationService.getAll();
        return new ResponseEntity<>(notifications, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Notification> getNotificationById(@PathVariable("id") Long id) {
        Notification notification = notificationService.getNotificationById(id);
        if (notification != null) {
            return new ResponseEntity<>(notification, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/create/all-users")
    public ResponseEntity<MessageResponse> createNotificationForAllUsers(@RequestBody Notification newNotification) {
        List<User> userList = userRepository.findAll(); // Lấy danh sách tất cả người dùng

        TypeNotify typeNotify = typeNotifyDAO.findById(1L).orElse(null);

        // Tạo thông báo cho mỗi người dùng trong danh sách
        for (User user : userList) {
            Notification notification = new Notification();
            notification.setTitle(newNotification.getTitle());
            notification.setContent(newNotification.getContent());
            notification.setNotificationDate(new Date());
            notification.setUser(user);
            notification.setIdUsers(user.getId());
            notification.setUserEmail(user.getEmail());

            notification.setTypeNotify(typeNotify);

            notificationService.create(notification);
        }

        MessageResponse response = new MessageResponse(true, "Đã gửi thông báo cho tất cả User");
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @PostMapping("/create/{userId}")
    public ResponseEntity<MessageResponse> createNotificationForSpecificUser(
            @PathVariable("userId") Long userId,
            @RequestBody Notification newNotification
    ) {
        User user = userRepository.findById(Math.toIntExact(userId)).orElse(null);

        if (user != null) {
            newNotification.setUser(user);
            newNotification.setIdUsers(user.getId());
            newNotification.setUserEmail(user.getEmail());
            newNotification.setNotificationDate(new Date());

            // Lấy thông tin TypeNotify từ cơ sở dữ liệu
            TypeNotify typeNotify = typeNotifyDAO.findById(1L).orElse(null);

            if (typeNotify != null) {
                newNotification.setTypeNotify(typeNotify); // Gán loại thông báo
            }


            Notification createdNotification = notificationService.create(newNotification);

            MessageResponse response = new MessageResponse(true, "Đã gửi thông báo cho người dùng với ID: " + userId);
            return new ResponseEntity<>(response, HttpStatus.CREATED);
        } else {
            MessageResponse response = new MessageResponse(false, "Người dùng với ID " + userId + " không tìm thấy");
            return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
        }
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<MessageResponse> updateNotification(
            @PathVariable("id") Long id,
            @RequestBody Notification updatedNotification
    ) {
        Notification existingNotification = notificationService.getNotificationById(id);

        if (existingNotification != null) {
            updatedNotification.setId(id);
            existingNotification.setNotificationDate(new Date());
            Notification updated = notificationService.update(updatedNotification);

            MessageResponse response = new MessageResponse(true, "Notification with ID " + id + " updated successfully");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } else {
            MessageResponse response = new MessageResponse(false, "Notification with ID " + id + " not found");
            return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Void> deleteNotification(@PathVariable("id") Long id) {
        Notification existingNotification = notificationService.getNotificationById(id);

        if (existingNotification != null) {
            notificationService.delete(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
