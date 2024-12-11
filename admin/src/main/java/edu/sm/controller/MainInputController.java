package edu.sm.controller;

import edu.sm.app.dto.AdminsDto;
import edu.sm.app.dto.RepairsDto;
import edu.sm.app.service.AdminsService;
import edu.sm.app.service.IotHistoryService;
import edu.sm.app.service.RepairsService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainInputController {

    final AdminsService adminsService;

    @RequestMapping("/logoutimpl")
    public String logoutimpl(HttpSession session, Model model) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/";
    }

    @RequestMapping("/loginimpl")
    public String loginimpl(Model model,
                            @RequestParam("id") String id,
                            @RequestParam("pwd") String pwd,
                            HttpSession session) throws Exception {
        log.info("ID: " + id);
        log.info("PWD: " + pwd);

        AdminsDto adminsDto = adminsService.get(id);

        if (adminsDto == null) {
            // 로그인 실패
            model.addAttribute("errorMessage", "ID가 존재하지 않습니다.");
            return "login";
        } else {
            // 로그인 성공
            if (pwd.equals(adminsDto.getAdminPwd())) {
                session.setAttribute("loginid", adminsDto);
                log.info(adminsDto.toString());
                return "redirect:/";
            } else {
                model.addAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
                return "login";
            }
        }
    }

    @RequestMapping("/registerimpl")
    public String registerimpl(Model model, AdminsDto adminsDto) throws Exception {
        adminsService.add(adminsDto);
        return "redirect:/login";
    }
}

