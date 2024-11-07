package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/park")
public class ParkController {
    String dir = "park/";

    @RequestMapping("")
    public String item(Model model){
        model.addAttribute("center", dir+"center");
        return "index";
    }

}
