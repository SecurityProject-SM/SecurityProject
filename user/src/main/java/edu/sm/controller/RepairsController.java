package edu.sm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/repairs")
public class RepairsController {

    @RequestMapping("")
    public String repairs(Model model) {
        return "index";
    }

    @RequestMapping("/calander")
    public String calander(Model model) {

        model.addAttribute("center", "calender");
        return "index";
    }

}
