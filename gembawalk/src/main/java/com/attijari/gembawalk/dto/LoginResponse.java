package com.attijari.gembawalk.dto;

public class LoginResponse {
    private String token;

    // Constructors
    public LoginResponse() {}

    public LoginResponse(String token) {
        this.token = token;
    }

    // Getter and Setter
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
