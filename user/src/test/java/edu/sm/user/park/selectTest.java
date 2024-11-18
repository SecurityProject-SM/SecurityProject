package edu.sm.user.park;

import edu.sm.app.service.ParkLogService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class selectTest {
    @Autowired
    ParkLogService parkLogService;

    @Test
    void contextLoads() {
        String test = "34나";
        try{
            parkLogService.findByCarNum(test);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
