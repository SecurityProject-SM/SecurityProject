package edu.sm.user.ncp;


import edu.sm.util.ChatBotUtil;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class ChatbotTest {

    @Value("${app.url.chatbot}")
    String url;

    @Value("${app.key.chatbot}")
    String key;

    @Test
    void contextLoads() throws Exception {
        String msg = "주차정산";
        String result = ChatBotUtil.getMsgUrl(url, key, msg);
        log.info("실행 결과 : " + result);
    }

}
