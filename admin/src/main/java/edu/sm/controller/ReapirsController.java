package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.AdminsDto;
import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.RepairsDto;
import edu.sm.app.dto.Search;
import edu.sm.app.service.NoticeService;
import edu.sm.app.service.RepairsService;
import jakarta.servlet.http.HttpSession;
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
public class ReapirsController {

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


    // 유지보수 메인페이지 띄우는것부터 시작하셈 ---------------------------------------

    @RequestMapping("/calender")
    public String calender(Model model) {
        model.addAttribute("center", "repairs/center");
        return"index";
    }
}
