package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.UsersDto;
import edu.sm.app.service.NoticeService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {

    final NoticeService noticeService;

    @RequestMapping("/")
    public String main(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo) {
        log.info("Loading main page with recent 3 notices");
        log.info("Started Main");
//        model.addAttribute("left", "left");
//        model.addAttribute("center", "center");


        PageInfo<NoticeDto> pageInfo = new PageInfo<>(noticeService.getMainNotice(pageNo), 5);
        model.addAttribute("recentNotices", pageInfo.getList());
        model.addAttribute("center", "center");
        model.addAttribute("target", "main");
        return "index";
    }

    @RequestMapping("/login")
    public String login(Model model) {
        log.info("Started login");
        return "login";
    }

    @RequestMapping("/register")
    public String register(Model model) {
        log.info("Started register");
        return "register";
    }

    @RequestMapping("/additional-info")
    public String additional(Model model) {
        return "additional-info";
    }

    // 모르겠으니까 일단 여기 작성했음
    @RequestMapping("/mypage")
    public String myPage(Model model, HttpSession session) throws Exception {
        UsersDto usersDto = (UsersDto) session.getAttribute("loginid");
        model.addAttribute("user", usersDto);
        model.addAttribute("center", "mypage");

        return "index";
    }


}
