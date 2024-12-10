package edu.sm.controller;

import edu.sm.app.service.GhtlfService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@Slf4j
@RequiredArgsConstructor
public class EnergyRestController {

    final GhtlfService ghtlfService;


//    @GetMapping("/getFloorEnergy")
//    public Map<String, Object> getFloorEnergy(@RequestParam("floor") String floor) {
//        Map<String, Object> result = new HashMap<>();
//        result.put("floor", floor);
//
//        List<Map<String, Object>> rooms = new ArrayList<>();
//        double totalPower = 0;
//
//        for (int i = 1; i <= 5; i++) {
//            Map<String, Object> room = new HashMap<>();
//            double power = 150 + Math.random() * 50; // 랜덤 전력량
//            totalPower += power;
//
//            room.put("room", floor + String.format("%02d호", i));
//            room.put("power", power + "kW");
//            room.put("temp", (24 + Math.random() * 5) + "°C");
//
//            // 상태 설정
//            String status;
//            if (power < 170) {
//                status = "normal";
//            } else if (power < 190) {
//                status = "warning";
//            } else {
//                status = "critical";
//            }
//            room.put("status", status);
//
//            rooms.add(room);
//        }
//
//        double avgPower = totalPower / 5; // 평균 전력량
//        result.put("avgPower", avgPower);
//        result.put("rooms", rooms);
//
//        return result;
//    }

    @GetMapping("/getFloorStats")
    public Object getFloorStats() throws Exception {
        Random random = new Random();
        JSONArray floorArray = new JSONArray(); // 전체 층 배열

        // 1층부터 5층까지 반복
        for (int i = 1; i <= 5; i++) {
            JSONObject floorObject = new JSONObject();
            String floorName = i + "F"; // 층 이름

            JSONArray roomArray = new JSONArray(); // 해당 층의 호실 배열
            int totalPower = 0;

            // 각 층별 5개의 호실 정보 생성
            for (int j = 1; j <= 8; j++) {
                JSONObject roomObject = new JSONObject();
                int power = random.nextInt(300); // 0 ~ 299kW 랜덤 전력량
                double temp = 20 + random.nextDouble() * 10; // 20~30°C 랜덤 온도

                roomObject.put("roomId", floorName + String.format("%02d", j) + "호");
                roomObject.put("power", power);
                roomObject.put("temperature", String.format("%.1f°C", temp));
                roomObject.put("status", getStatus(power)); // 상태 계산
                roomArray.add(roomObject);

                totalPower += power; // 층의 전체 전력량 누적
            }

            // 층 정보 구성
            floorObject.put("floor", floorName);
            floorObject.put("totalPower", totalPower);
            floorObject.put("rooms", roomArray); // 층의 호실 배열 추가
            floorObject.put("status", getStatus(totalPower)); // 층의 상태

            floorArray.add(floorObject); // 전체 층 배열에 추가
        }

        // 최종 결과 반환
        JSONObject result = new JSONObject();
        result.put("buildingStats", floorArray);
        return result;
    }

    // 전력량에 따른 상태 계산
    private String getStatus(int power) {
        if (power > 250) {
            return "critical"; // 빨강
        } else if (power > 200) {
            return "warning"; // 주황
        } else {
            return "normal"; // 초록
        }
    }


    @RequestMapping("/vacancy")
    public int vacancy() {
        return ghtlfService.vacancy();
    }
}
