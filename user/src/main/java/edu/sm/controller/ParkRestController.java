package edu.sm.controller;

import edu.sm.app.dto.ParkDto;
import edu.sm.app.service.ParkService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
public class ParkRestController {

    final ParkService parkService;

    @RequestMapping("/getctime")
    public Object getctime() {
        JSONObject obj = new JSONObject();
        LocalDateTime now = LocalDateTime.now();
        obj.put("cday", DateTimeFormatter.ofPattern("yyyy-MM-dd EEEE").format(now));
        obj.put("ctime", DateTimeFormatter.ofPattern("HH:mm:ss").format(now));
        return obj;
    }

    @RequestMapping("/getparkstat")
    public Object getparkstat() throws Exception {
        List<ParkDto> parkList = parkService.get();
        JSONArray arr = new JSONArray();
        int availableCount = 0;
        for (ParkDto park : parkList) {
            JSONObject obj = new JSONObject();
            obj.put("parkId", park.getParkId());
            obj.put("parkStat", park.getParkStat());
            arr.add(obj);
            if (park.getParkStat()) {
                availableCount++;
            }
        }
        JSONObject result = new JSONObject();
        result.put("parkingData", arr);
        result.put("availableCount", availableCount);
        return result;
    }

    @RequestMapping("/parksetsum")
    public Object parksetsum(String carNumber) {
        // 요금 계산은 Service 계층에서 수행
        return parkService.parksetsum(carNumber);
    }
}
