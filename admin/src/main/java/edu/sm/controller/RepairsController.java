package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.RepairsDto;
import edu.sm.app.service.RepairsService;
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

    String dir = "repairs/";
    final RepairsService repairsService;

    @RequestMapping("")
    public String repairs(Model model) {
        model.addAttribute("center", dir+"center");
        return "index";
    }

/*    @RequestMapping("/calender")
    public String calander(Model model) {

        model.addAttribute("center", "repairs/calender");
        return "index";
    }*/

    @RequestMapping("/success")
    public String success(@RequestParam("id") int id) {

        repairsService.suc(id);
        return "redirect:/repairs";
    }
}