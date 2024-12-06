package edu.sm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@Slf4j
@RequestMapping("/energy")
public class EnergyController {
    String dir = "energy/";


    @RequestMapping("")
    public String item(Model model){
        model.addAttribute("center", dir+"center");
        return "index";
    }

    @RequestMapping("/info")
    public String info(Model model){
        model.addAttribute("center", "energy/info");
        return "index";
    }

}
