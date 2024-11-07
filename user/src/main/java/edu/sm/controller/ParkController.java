package edu.sm.controller;

import edu.sm.app.service.ParkService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/park")
@RequiredArgsConstructor
public class ParkController {
    String dir = "park/";

    private final ParkService parkService;

    @RequestMapping("")
    public String item(Model model){
        model.addAttribute("center", dir+"center");
        return "index";
    }

    @RequestMapping("/calc")
    public String calc(Model model) {
        log.info("calc run");
        model.addAttribute("center", "park/calc");
        return "index";
    }

}
