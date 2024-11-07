package edu.sm.user.notice;

import edu.sm.app.service.NoticeService;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class SelectTest {

    @Autowired
    NoticeService noticeService;

    @Test
    public void contextLoads() {
        try {
            noticeService.getTop3Notices();
        }catch (Exception e){
            log.error(e.getMessage());
        }
    }
}
