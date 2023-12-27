package com.fahasa.RestController;

import com.fahasa.dao.MessageResponse;
import com.fahasa.model.ChangePasswordRequest;
import com.fahasa.model.User;
import com.fahasa.reponsitory.UserRepository;
import io.micrometer.common.util.StringUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/user/change-password")
@RequiredArgsConstructor
@CrossOrigin("*")
public class ChangePasswordController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping
    public ResponseEntity<MessageResponse> changePassword(@RequestBody ChangePasswordRequest request) {
        // Kiểm tra tính hợp lệ của yêu cầu
        if (StringUtils.isEmpty(request.getEmail())) {
            return ResponseEntity.badRequest().body(new MessageResponse(false, "Email không được để trống"));
        }

        if (StringUtils.isEmpty(request.getCurrentPassword())) {
            return ResponseEntity.badRequest().body(new MessageResponse(false, "Mật khẩu hiện tại không được để trống"));
        }

        if (StringUtils.isEmpty(request.getNewPassword())) {
            return ResponseEntity.badRequest().body(new MessageResponse(false, "Mật khẩu mới không được để trống"));
        }

        // Tìm kiếm người dùng
        User user = userRepository.findByEmail(request.getEmail()).orElseThrow(() -> new IllegalArgumentException("Email không tồn tại"));

        // Kiểm tra mật khẩu hiện tại
        if (!passwordEncoder.matches(request.getCurrentPassword(), user.getPassword())) {
            return ResponseEntity.badRequest().body(new MessageResponse(false, "Mật khẩu hiện tại không chính xác"));
        }

        // Cập nhật mật khẩu
        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);

        // Trả về kết quả
        return ResponseEntity.ok(new MessageResponse(true, "Mật khẩu đã được thay đổi thành công"));
    }
}
