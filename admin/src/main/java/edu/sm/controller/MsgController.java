package edu.sm.controller;

import edu.sm.app.dto.Msg;
import edu.sm.util.PapagoUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.regex.Pattern;

@RequiredArgsConstructor
@Slf4j
@Controller
public class MsgController {

    private final SimpMessageSendingOperations simpMessageSendingOperations;

    @Autowired
    SimpMessagingTemplate template;

    @Value("${app.url.server-url}")
    private String serverurl;


//    파파고 키값
    @Value("${app.key.papago-id}")
    String clientId;
    @Value("${app.key.papago-secret}")
    String clientSecret;

    @MessageMapping("/receive/user") // 사용자가 메시지를 보낼 때
    public void receiveUserMessage(Msg msg) {
        String txt = msg.getContent1();
        template.convertAndSend("/send/userme",msg); // 특정 사용자에게 전송

        if(Pattern.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*",txt)){
            template.convertAndSend("/send/user",msg); // 특정 사용자에게 전송
        }else{
            String tmsg = PapagoUtil.getMsg(clientId, clientSecret, txt, "ko");
            msg.setContent1(tmsg);
            template.convertAndSend("/send/user",msg); // 특정 사용자에게 전송
        }
    }

    @MessageMapping("/receive/admin") // 관리자가 메시지를 보낼 때
    public void receiveAdminMessage(Msg msg) {
        String txt = msg.getContent1();
        template.convertAndSend("/send/admin",msg); // 모든 관리자가 구독 중인 경로에 전송
    }


    @RequestMapping("/testchat")
    public String testchat(Model model) {
        model.addAttribute("serverurl", serverurl);
        return "index";
    }
}