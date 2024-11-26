package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.UsersDto;
import edu.sm.app.service.NoticeService;
import edu.sm.util.WeatherUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {

    @Value("${app.key.wkey}")
    private String wkey;

    @Value("${app.key.okey}")
    private String okey;

    @Value("${app.url.server-url}")
    private String serverurl;

    final NoticeService noticeService;

    @RequestMapping("/")
    public String main(Model model) {
        log.info("Started Main");
        List<NoticeDto> recentNotices = noticeService.getTop3Notices();
        model.addAttribute("serverurl", serverurl);
        model.addAttribute("recentNotices", recentNotices);

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

    @RequestMapping("/webs")
    public String test(Model model) {
        log.info("Started test");
        return "adminchat";
    }

    // 메인화면 날씨
    @RequestMapping("/ow")
    @ResponseBody
    public Object oh(Model model) throws IOException, ParseException {
        return WeatherUtil.getWeather2("36.804125", "127.1524667", okey);
    }


}


