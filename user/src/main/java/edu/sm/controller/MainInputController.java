package edu.sm.controller;

import edu.sm.app.dto.Msg;
import edu.sm.app.dto.UsersDto;
import edu.sm.app.service.NoticeService;
import edu.sm.app.service.UsersService;
import edu.sm.util.ChatBotUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import edu.sm.util.ChatBotUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainInputController {

    final UsersService usersService;
    final NoticeService noticeService;
    final SimpMessagingTemplate template;

    @Value("${app.url.chatbot}")
    String url;
    @Value("${app.key.chatbot}")
    String key;

    // 로그아웃 처리
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

        UsersDto usersDto = usersService.get(id);

        if (usersDto == null) {
            // 로그인 실패
            model.addAttribute("errorMessage", "ID가 존재하지 않습니다.");
            return "login";
        } else {
            // 로그인 성공
            if (pwd.equals(usersDto.getUserPwd())) {
                session.setAttribute("loginid", usersDto);
                log.info(usersDto.toString());
                return "redirect:/";
            } else {
                // 로그인 실패: 비밀번호 불일치
                model.addAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
                return "login";  // 다시 login.jsp로 이동
            }
        }
    }

    @RequestMapping("/additionalimpl")
    public String additionalimpl(HttpSession session, UsersDto usersDto, Model model) throws Exception {
        UsersDto sessionUser = (UsersDto) session.getAttribute("loginid");

        if (sessionUser == null) {
            return "redirect:/login";
        }

        usersDto.setUserId(sessionUser.getUserId());
        usersService.updateAdditionalInfo(usersDto);

        session.setAttribute("loginid", usersDto);

        return "redirect:/";
    }

    @RequestMapping("/registerimpl")
    public String registerimpl(Model model, UsersDto usersDto) throws Exception {
        usersService.add(usersDto);
        return "redirect:/login";
    }

    @RequestMapping("/updateimpl")
    public String updateUserInfo(UsersDto updatedUser, HttpSession session, Model model) throws Exception {
        UsersDto sessionUser = (UsersDto) session.getAttribute("loginid");

        if (sessionUser == null) {
            return "redirect:/login";
        }

        updatedUser.setUserId(sessionUser.getUserId());
        usersService.modify(updatedUser);
        session.setAttribute("loginid", updatedUser);

        model.addAttribute("user", updatedUser);
        model.addAttribute("center", "mypage");

        return "index";
    }

    @RequestMapping("/deleteimpl")
    public String deleteUser(@RequestParam("id") String id, HttpSession session) throws Exception {
        usersService.del(id);
        session.invalidate();
        return "redirect:/";
    }

    @MessageMapping("/sendchatbot") // 특정 Id에게 전송
    public void sendchat(Msg msg, SimpMessageHeaderAccessor headerAccessor) throws Exception {
        String id = msg.getSendid();
        String content = msg.getContent1();
        log.info("-------------------------");
        log.info(msg.toString());

        String result = ChatBotUtil.getMsgUrl(url,key, content);
        msg.setContent1(result);

        template.convertAndSend("/sendto/"+id,msg);

    }

}
