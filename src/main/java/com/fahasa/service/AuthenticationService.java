package com.fahasa.service;

import com.fahasa.dao.JwtAuthenticationResponse;
import com.fahasa.dao.RefreshTokenRequest;
import com.fahasa.dao.SignInRequest;
import com.fahasa.dao.SignUpRequest;
import com.fahasa.model.User;

public interface AuthenticationService {

    User signup(SignUpRequest signUpRequest);

    JwtAuthenticationResponse signin(SignInRequest signInRequest);

    JwtAuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest);
}
