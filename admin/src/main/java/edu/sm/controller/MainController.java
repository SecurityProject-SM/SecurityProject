package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
public class MainController {

    @RequestMapping("/")
    public String index(Model model) {
        log.info("Started Main,,,,");
        model.addAttribute("center", "center");
        return "index";
    }

    @RequestMapping("/login")
    public String login(Model model) {
        log.info("Started Login,,,,");
        return "login";
    }

    @RequestMapping("/register")
    public String register(Model model) {
        log.info("Started register,,,,");
        return "register";
    }
}
