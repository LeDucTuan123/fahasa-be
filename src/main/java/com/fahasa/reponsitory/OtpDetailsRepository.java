package com.fahasa.reponsitory;

import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.fahasa.model.OtpDetails;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface OtpDetailsRepository  extends JpaRepository<OtpDetails, Long> {
    List<OtpDetails> findByEmailAndOtpAndExpiryTimeAfter(String email, String otp,LocalDateTime expiryTime);
    @Transactional
    @Modifying
    @Query("DELETE FROM OtpDetails o WHERE o.email = :email")
    int deleteByEmail(@Param("email") String email);

    void deleteByExpiryTimeBefore(LocalDateTime currentTime);
}
