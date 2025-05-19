package com.attijari.gembawalk.controller;

import com.attijari.gembawalk.dto.LoginRequest;
import com.attijari.gembawalk.dto.LoginResponse;
import com.attijari.gembawalk.entity.User;
import com.attijari.gembawalk.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "*", methods = {RequestMethod.POST, RequestMethod.OPTIONS}, allowedHeaders = {"Content-Type", "Authorization"})
@RestController
@RequestMapping("/api/auth")
public class AuthController {

//remove the autowired , inject with constructor pour faciliter les tests unitaires
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
     * Endpoint pour l'inscription (pour tests). Permet de spécifier le rôle dans le LoginRequest.
     * Si aucun rôle n'est spécifié, le rôle par défaut sera DASHBOARD_VIEWER.
     */
    @PostMapping("/register")
    public ResponseEntity<User> register(@RequestBody LoginRequest registerRequest){
        User user = authService.register(
                registerRequest.getEmail(),
                registerRequest.getPassword(),
                registerRequest.getRole()
        );
        return ResponseEntity.ok(user);
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<String> handleRuntimeException(RuntimeException ex) {
        if (ex.getMessage().equals("User already exists")) {
            return new ResponseEntity<>(ex.getMessage(), org.springframework.http.HttpStatus.CONFLICT);
        } else if (ex.getMessage().startsWith("Role not found")) {
            return new ResponseEntity<>(ex.getMessage(), org.springframework.http.HttpStatus.BAD_REQUEST);
        } else if (ex.getMessage().equals("Default role not found: DASHBOARD_VIEWER")) {
            return new ResponseEntity<>(ex.getMessage(), org.springframework.http.HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>("An unexpected error occurred during registration", org.springframework.http.HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
