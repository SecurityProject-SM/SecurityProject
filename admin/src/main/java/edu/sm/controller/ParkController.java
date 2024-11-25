package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.RepairsDto;
import edu.sm.app.service.ParkLogService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/park")
public class ParkController {

    final ParkLogService parkLogService;

    @RequestMapping("")
    public String repairs(Model model) {

        model.addAttribute("center", "park/center");
        return "index";
    }

    @RequestMapping("/summery")
    public String summery(Model model) {

        model.addAttribute("center", "park/summery");
        return "index";
    }

}
