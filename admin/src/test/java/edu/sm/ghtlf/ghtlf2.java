package edu.sm.ghtlf;

import edu.sm.app.dto.AdminsDto;
import edu.sm.app.service.GhtlfService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class ghtlf2 {
    @Autowired
    GhtlfService ghtlfService;

    @Test
    void contextLoads() {
        Integer i = 1;
        try{
            ghtlfService.get(1);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
