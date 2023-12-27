package com.fahasa.RestController;

import com.fahasa.dao.MessageResponse;
import com.fahasa.model.ChangeEmailRequest;
import com.fahasa.model.OtpDetails;
import com.fahasa.model.User;
import com.fahasa.reponsitory.OtpDetailsRepository;
import com.fahasa.reponsitory.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/v1/user/change-email")
public class ChangeEmailController {

    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private OtpDetailsRepository otpDetailsRepository;

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/request")
    public ResponseEntity<MessageResponse> requestChangeEmail(@RequestBody ChangeEmailRequest request) {
        // Kiểm tra xem email mới đã tồn tại trong hệ thống hay chưa
        Optional<User> existingUser = userRepository.findByEmail(request.getNewEmail());
        if (existingUser.isPresent()) {
            return ResponseEntity.badRequest().body(new MessageResponse(false, "Email đã tồn tại trong hệ thống"));
        }

        // Gửi OTP đến email mới
        String otp = generateRandomOtp();
        LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(2);

        saveOtpDetails(request.getNewEmail(), otp, expiryTime);
        sendOtpByEmail(request.getNewEmail(), otp);

        return ResponseEntity.ok(new MessageResponse(true, "Mã OTP đã được gửi"));
    }

    @PostMapping("/validate")
    public ResponseEntity<MessageResponse> validateOtp(@RequestBody ChangeEmailRequest request) {
        LocalDateTime currentTime = LocalDateTime.now();
        List<OtpDetails> validOtps = otpDetailsRepository.findByEmailAndOtpAndExpiryTimeAfter(request.getNewEmail(), request.getOtp(), currentTime);
        if (validOtps.isEmpty()) {
            return ResponseEntity.badRequest().body(new MessageResponse(false, "Mã OTP không hợp lệ"));
        } else {
            return ResponseEntity.ok(new MessageResponse(true, "Mã OTP hợp lệ"));
        }
    }

    @PostMapping("/update")
    public ResponseEntity<MessageResponse> updateEmail(@RequestBody ChangeEmailRequest request) {
        Optional<User> optionalUser = userRepository.findByEmail(request.getEmail());

        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            user.setEmail(request.getNewEmail());
            userRepository.save(user);

            // Xóa thông tin về OTP liên quan đến người dùng
            otpDetailsRepository.deleteByEmail(request.getEmail());
            return ResponseEntity.ok(new MessageResponse(true, "Email đã được thay đổi thành công"));
        } else {
            return ResponseEntity.badRequest().body(new MessageResponse(false, "Email không tồn tại"));
        }

    }

    private void saveOtpDetails(String email, String otp, LocalDateTime expiryTime) {
        OtpDetails otpDetails = new OtpDetails();
        otpDetails.setEmail(email);
        otpDetails.setOtp(otp);
        otpDetails.setExpiryTime(expiryTime);
        otpDetailsRepository.save(otpDetails);
    }

    private void sendOtpByEmail(String email, String otp) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("Reset mật khẩu");
        message.setText("Mã OTP của bạn là: " + otp);
        javaMailSender.send(message);
    }

    private String generateRandomOtp() {
        int length = 6;
        String charset = "0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new SecureRandom();

        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(charset.length());
            sb.append(charset.charAt(randomIndex));
        }

        return sb.toString();
    }
}
