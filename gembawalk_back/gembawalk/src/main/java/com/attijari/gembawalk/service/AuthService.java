package com.attijari.gembawalk.service;

import com.attijari.gembawalk.dto.LoginRequest;
import com.attijari.gembawalk.dto.LoginResponse;
import com.attijari.gembawalk.entity.User;
import com.attijari.gembawalk.entity.Role;
import com.attijari.gembawalk.repository.UserRepository;
import com.attijari.gembawalk.repository.RoleRepository;
import com.attijari.gembawalk.config.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    /**
     * Authentifie l'utilisateur et génère un token JWT
     */
    public LoginResponse login(LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getEmail(), loginRequest.getPassword())
        );
        String token = jwtUtil.generateToken(authentication);
        return new LoginResponse(token);
    }

    public User register(String email, String password, String roleName) {
        if(userRepository.findByEmail(email).isPresent()){
            throw new RuntimeException("User already exists");
        }

        Role role;
        if (roleName != null && !roleName.isEmpty()) {
            role = roleRepository.findByName(roleName)
                    .orElseThrow(() -> new RuntimeException("Role not found: " + roleName));
        } else {
            role = roleRepository.findByName("DASHBOARD_VIEWER")
                    .orElseThrow(() -> new RuntimeException("Default role not found: DASHBOARD_VIEWER"));
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(password));
        user.setRole(role);

        return userRepository.save(user);
    }

    public User register(String email, String password) {
        return register(email, password, null);
    }
}
