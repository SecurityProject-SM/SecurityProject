package edu.sm.ghtlf;

import edu.sm.app.dto.AdminsDto;
import edu.sm.app.service.AdminsService;
import edu.sm.app.service.GhtlfService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class ghtlf {
    @Autowired
    GhtlfService ghtlfService;

    @Test
    void contextLoads() {
        AdminsDto adminsDto = AdminsDto.builder().adminId("test01").adminPwd("1111").adminTel("test").adminEmail("test@df").adminName("test").build();
        try{
            ghtlfService.get();
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
