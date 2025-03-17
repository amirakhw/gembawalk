package com.attijari.gembawalk.controller;

import com.attijari.gembawalk.dto.LoginRequest;
import com.attijari.gembawalk.dto.LoginResponse;
import com.attijari.gembawalk.entity.User;
import com.attijari.gembawalk.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    /**
     * Endpoint pour se connecter. Retourne un token JWT.
     */
    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest loginRequest){
        LoginResponse response = authService.login(loginRequest);
        return ResponseEntity.ok(response);
    }

    /**
     * Endpoint pour l'inscription. Utilise le LoginRequest pour récupérer email et mot de passe.
     * Le rôle par défaut sera DASHBOARD_VIEWER.
     */
    @PostMapping("/register")
    public ResponseEntity<User> register(@RequestBody LoginRequest loginRequest){
        User user = authService.register(loginRequest.getEmail(), loginRequest.getPassword());
        return ResponseEntity.ok(user);
    }
}
