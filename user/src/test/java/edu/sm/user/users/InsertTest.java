package edu.sm.user.users;

import edu.sm.app.dto.UsersDto;
import edu.sm.app.service.UsersService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class InsertTest {
    @Autowired
    UsersService usersService;

    @Test
    void contextLoads() {
        UsersDto usersDto = UsersDto.builder().userId("test01").userPwd("1111")
                .userTel("010-1111-2222").userMail("test01@gmail.com").userName("테스터01")
                .userPower(false).userFlag(false).build();
        try{
            usersService.add(usersDto);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
