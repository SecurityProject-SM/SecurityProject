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
    public Object getctime(){
        JSONObject obj = new JSONObject();
        LocalDateTime now = LocalDateTime.now();
        // {'ctime', '2023-12-12'}
        obj.put("cday", DateTimeFormatter.ofPattern("yyyy-MM-dd EEEE").format(now));
        obj.put("ctime", DateTimeFormatter.ofPattern("HH:mm:ss").format(now));
        return obj;
    }

    @RequestMapping("/getparkstat")
    public Object getparkstat() throws Exception{
        List<ParkDto> parkList = parkService.get();
        JSONArray arr = new JSONArray();
        int availableCount = 0;
        for (ParkDto park : parkList) {
            JSONObject obj = new JSONObject();
            obj.put("parkId", park.getParkId());  // 주차 ID
            obj.put("parkStat", park.getParkStat());  // 주차 상태 (true/false)
            arr.add(obj);
            if (park.getParkStat()) {
                availableCount++;
            }
        }

        // 최종 반환할 JSONObject에 주차 상태 배열과 가능 자리 수 추가
        JSONObject result = new JSONObject();
        result.put("parkingData", arr); // 모든 주차 상태 배열
        result.put("availableCount", availableCount); // 주차 가능한 자리 개수

        return result;
    }
}
