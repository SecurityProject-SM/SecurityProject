package edu.sm.user.repairs;


import edu.sm.app.dto.RepairsDto;
import edu.sm.app.dto.UsersDto;
import edu.sm.app.service.RepairsService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class insertRepairs
{
    @Autowired
    private RepairsService repairsService;

    @Test
    void contextLoads() {
        RepairsDto repairsDto = RepairsDto.builder()
                .buildingId("B001")
                .iotId("IOT1")
                .repairStat("A")
                .repairLoc("건어물학원 강의실5")
                .build();
        try{
            repairsService.add(repairsDto);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
