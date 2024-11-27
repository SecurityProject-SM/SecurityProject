package edu.sm.controller;

import edu.sm.app.dto.Msg;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
public class MsgController {
    @Autowired
    SimpMessagingTemplate template;

    @Value("${app.url.server-url}")
    private String serverurl;


    @MessageMapping("/receiveall") // 모두에게 전송
    public void receiveall(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
        log.info("===================================================="+msg);
        template.convertAndSend("/send",msg);
    }

    @MessageMapping("/receiveme") // 나에게만 전송 ex)Chatbot
    public void receiveme(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
        System.out.println(msg);

        String id = msg.getSendid();
        template.convertAndSend("/send/"+id,msg);
    }

    @MessageMapping("/receiveto") // 특정 Id에게 전송
    public void receiveto(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
        String id = msg.getSendid();
        String target = msg.getReceiveid();
        log.info("-------------------------");
        log.info(target);

        template.convertAndSend("/send/to/"+target,msg);
    }

    @RequestMapping("/testchat")
    public String testchat(Model model) {
        model.addAttribute("serverurl", serverurl);
        return "index";
    }
}