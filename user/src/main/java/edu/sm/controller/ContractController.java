package edu.sm.controller;

import edu.sm.app.dto.ContractDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/contract")
public class ContractController {
    String dir = "contract/";

    @RequestMapping("")
    public String viewContract(Model model) {
        model.addAttribute("left", dir + "left"); // left.jsp 파일을 가리킴
        model.addAttribute("center", dir + "center"); // center.jsp 파일을 가리킴
        return "index";
    }
}
