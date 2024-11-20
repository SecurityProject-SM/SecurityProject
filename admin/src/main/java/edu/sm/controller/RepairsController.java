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

    final RepairsService repairsService;

    @RequestMapping("")
    public String repairs(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo) {
        log.info("Loading repairs list - page {}", pageNo);

        PageInfo<RepairsDto> pageInfo = new PageInfo<>(repairsService.getRepairsPage(pageNo), 5); // 페이지네이션 설정
        model.addAttribute("cpage", pageInfo);
        model.addAttribute("center", "repairs/center"); // 수정된 경로
        model.addAttribute("target", "repairs"); // 수정된 target 이름
        return "index";
    }

    @RequestMapping("/calender")
    public String calander(Model model) {

        model.addAttribute("center", "repairs/calender");
        return "index";
    }

    @RequestMapping("/success")
    public String success(@RequestParam("id") int id) {

        repairsService.suc(id);
        return "redirect:/repairs";
    }

}