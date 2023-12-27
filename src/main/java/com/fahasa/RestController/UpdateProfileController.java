package com.fahasa.RestController;

import com.fahasa.dao.MessageResponse;
import com.fahasa.model.User;
import com.fahasa.reponsitory.UserRepository;
import com.fahasa.service.impl.UserServiceImpl;
import io.micrometer.common.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/user/change-info")
@CrossOrigin("*")
public class UpdateProfileController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping
    public ResponseEntity<MessageResponse> changeInfo(@RequestBody User request) {
        // Kiểm tra tính hợp lệ của yêu cầu
        if (StringUtils.isEmpty(request.getEmail())) {
            return ResponseEntity.badRequest().body(new MessageResponse(false, "Email không được bỏ trống"));
        }

        // Tìm kiếm người dùng
        User user = userRepository.findByEmail(request.getEmail()).orElseThrow(() -> new IllegalArgumentException("Email không tồn tại"));

        // Cập nhật thông tin người dùng
        user.setFirstname(request.getFirstname());
        user.setLastname(request.getLastname());
        user.setGender(request.getGender());
        user.setBirthday(request.getBirthday());
        userRepository.save(user);

        // Trả về kết quả
        return ResponseEntity.ok(new MessageResponse(true, "Đã lưu thông tin"));
    }
}
