package edu.sm.user.iothistory;

import edu.sm.app.service.IotHistoryService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class humtempTest {
    @Autowired
    IotHistoryService iotHistoryService;

    @Test
    void contextLoads() {
        try{
            iotHistoryService.getCurHum();
            iotHistoryService.getCurTemp();
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
