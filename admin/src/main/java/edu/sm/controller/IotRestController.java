package edu.sm.controller;


import edu.sm.app.service.IotHistoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/iot")
public class IotRestController {

    private final IotHistoryService iotHistoryService;

    @RequestMapping("/monthelec")
    public ResponseEntity<List<Map<String, Object>>> getMonthlyElectricityUsage() {
        try {
            List<Map<String, Object>> monthlyElectricityUsage = iotHistoryService.monthelec();
            return ResponseEntity.ok(monthlyElectricityUsage); // JSON 반환
        } catch (Exception e) {
            log.error("Error fetching monthly electricity usage", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

}
