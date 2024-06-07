package com.example.doorspring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DoorspringController {
    
    @Value("${SB_MESSAGE:If you want to test env var change me [SB_MESSAGE]}")
    private String message;

    @GetMapping("/")
    public String welcome() {
        return "Hello ! You use Cloodour with deploy Spring Boot application. \n" + message;
    }
}