package edu.sm.admin;

import edu.sm.app.dto.AdminsDto;
import edu.sm.app.dto.UsersDto;
import edu.sm.app.service.AdminsService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class InsertTest {
    @Autowired
    AdminsService adminsService;

    @Test
    void contextLoads() {
        AdminsDto adminsDto = AdminsDto.builder().adminId("test01").adminPwd("1111").adminTel("test").adminEmail("test@df").adminName("test").build();
        try{
            adminsService.add(adminsDto);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
