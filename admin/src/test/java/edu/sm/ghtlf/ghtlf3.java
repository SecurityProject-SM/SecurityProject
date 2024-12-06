package edu.sm.ghtlf;

import edu.sm.app.dto.AdminsDto;
import edu.sm.app.dto.GhtlfDto;
import edu.sm.app.service.GhtlfService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class ghtlf3 {
    @Autowired
    GhtlfService ghtlfService;

    @Test
    void contextLoads() {
        GhtlfDto ghtlfDto =  GhtlfDto.builder().bname("test").room(102).dlfma("테스트").tel("010-2983-3781").ghtlfid(2).build();
        try{
            ghtlfService.updateus(ghtlfDto);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
