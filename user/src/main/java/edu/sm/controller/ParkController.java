package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

    @RequestMapping("/parkpay")
    public String parkpay(Model model) {
        model.addAttribute("center", dir + "parkpay");
        return "index";
    }

    @RequestMapping("/parkset")
    public String parkset(Model model) {
        model.addAttribute("center", dir + "parkset");
        return "index";
    }

    @RequestMapping("/parkloc")
    public String parkloc(Model model) {
        model.addAttribute("center", dir + "parkloc");
        return "index";
    }

    @RequestMapping("/parksetsum")
    public Object parksetsum(String carIn, String carOut) {
        // 데이터가 제대로 전달되었는지 로그로 출력
        log.info("Received carIn: {}", carIn);
        log.info("Received carOut: {}", carOut);
        return null;
    }
    @RequestMapping("/calc")
    public String calc(Model model) {
        log.info("calc run");
        model.addAttribute("center", "park/calc");
        return "index";
    }
}
