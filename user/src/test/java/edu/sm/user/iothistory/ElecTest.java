package edu.sm.user.iothistory;

import edu.sm.app.service.IotHistoryService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Map;

@SpringBootTest
@Slf4j
public class ElecTest {

    @Autowired
    IotHistoryService iotHistoryService;

    @Test
    void testMonthelec() {
        try {
            List<Map<String, Object>> result = iotHistoryService.monthelec();

            for (Map<String, Object> record : result) {
                log.info("Month: {}, Total Value: {}",
                        record.get("month"),
                        record.get("total_value"));
            }
        } catch (Exception e) {
            log.error("Error occurred while fetching monthly electricity usage", e);
            throw new RuntimeException(e);
        }
    }
}
