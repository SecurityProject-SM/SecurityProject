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
        int buildingTotalPower = 0; // 건물 전체 전력량

        // 1층부터 5층까지 반복
        for (int i = 1; i <= 5; i++) {
            JSONObject floorObject = new JSONObject();
            String floorName = i + "F"; // 층 이름

            JSONArray roomArray = new JSONArray(); // 해당 층의 호실 배열
            int totalPower = 0;

            // 각 층별 5개의 호실 정보 생성
            for (int j = 1; j <= 8; j++) {
                JSONObject roomObject = new JSONObject();

                int power;
                if(i==5) {
                    power = 70 + random.nextInt(60);
                }else {
                    if (j == 2 || j == 8) {
                        power = 60 + random.nextInt(41); // 60 ~ 100 사이의 랜덤 전력량
                    } else if (j == 6) {
                        power = 100 + random.nextInt(21); // 100 ~ 120 사이의 랜덤 전력량
                    } else {
                        power = 20 + random.nextInt(25); // 20 ~ 45 사이의 랜덤 전력량
                    }
                }


                double temp = 22 + random.nextDouble() * 5; // 20~30°C 랜덤 온도

                roomObject.put("roomId", floorName + String.format("%02d", j) + "호");
                roomObject.put("power", power);
                roomObject.put("temperature", String.format("%.1f°C", temp));
                roomObject.put("status", getStatus(power)); // 상태 계산
                roomArray.add(roomObject);

                totalPower += power; // 층의 전체 전력량 누적
            }
            buildingTotalPower += totalPower; // 건물 전체 전력량 누적
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
        result.put("buildingTotalPower", buildingTotalPower); // 건물 전체 전력량 추가
        return result;
    }

    // 전력량에 따른 상태 계산
    private String getStatus(int power) {
        if (power > 100) {
            return "critical"; // 빨강
        } else if (power > 60) {
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
