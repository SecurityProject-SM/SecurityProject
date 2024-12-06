package edu.sm.controller;

import edu.sm.app.dto.ParkDto;
import edu.sm.app.dto.ParkLogDto;
import edu.sm.app.service.ParkLogService;
import edu.sm.app.service.ParkService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

@RestController
@Slf4j
@RequiredArgsConstructor
public class ParkRestController {

    final ParkService parkService;
    final ParkLogService parkLogService;

    @RequestMapping("/getctime")
    public Object getctime() {
        JSONObject obj = new JSONObject();
        LocalDateTime now = LocalDateTime.now();
        // {'ctime', '2023-12-12'}
        obj.put("cday", DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 EEEE").format(now));
        obj.put("ctime", DateTimeFormatter.ofPattern("a hh:mm:ss").format(now));
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

        // 최종 반환할 JSONObject에 주차 상태 배열과 가능 자리 수 추가
        JSONObject result = new JSONObject();
        result.put("parkingData", arr);
        result.put("availableCount", availableCount);

        return result;
    }

    @RequestMapping("/parksetsum")
    public Object parksetsum(String carNumber) {
        // 요금 계산은 Service 계층에서 수행
        return parkLogService.parksetsum(carNumber);
    }

//    @RequestMapping("/car_find")
//    public JSONArray carfind(@RequestParam("carNum") String carNum) throws Exception {
//        log.info("차량 번호: " + carNum);
//        List<ParkLogDto> carList = parkLogService.findByCarNum(carNum);
//
//        JSONArray jsonArray = new JSONArray();
//        for (ParkLogDto car : carList) {
//            JSONObject obj = new JSONObject();
//            obj.put("parkLogId", car.getParkLogId());
//            obj.put("parkId", car.getParkId());
//            obj.put("carNum", car.getCarNum());
//            obj.put("carIn", car.getCarIn().toString());
//            obj.put("carOut", car.getCarOut() != null ? car.getCarOut().toString() : "미출차");
//            obj.put("carPay", car.getCarPay());
//            jsonArray.add(obj);
//        }
//
//        return jsonArray;
//    }

}
