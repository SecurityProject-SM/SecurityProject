package edu.sm.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.sm.app.dto.IotDto;
import edu.sm.app.service.IotServcie;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.io.input.ReversedLinesFileReader;
@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/iot")
public class IotRestController {

    private static final String LOG_FILE_PATH = "C:\\SmartBuildingProject\\logs\\data.log";
    private final IotServcie iotServcie;


    @RequestMapping("/data")
    public String receiveIoTData(@RequestBody String data) {
        log.info(data);
        return data;
    }

//    @RequestMapping("/status")
//    public Map<String, Boolean> getAllIotStatus(){
//        Map<String, Boolean> iotStatus = new HashMap<>();
//        try {
//            List<IotDto> iotList = iotServcie.get();
//            for (IotDto iot : iotList) {
//                iotStatus.put(iot.getIotId(), iot.isIotStatus());
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return iotStatus;
//    }

    //테이블에 뿌리는 코드
    @RequestMapping("/latestData")
    public Map<String, Object> getLatestData() {
        Map<String,Map<String, Map<String,Object>>> latestPowerData = new HashMap<>();
        latestPowerData.put("T", new HashMap<>());
        latestPowerData.put("H", new HashMap<>());
        latestPowerData.put("E", new HashMap<>());

        File file = new File(LOG_FILE_PATH);
        try (ReversedLinesFileReader br = new ReversedLinesFileReader(file)) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(", ", 2);
                if (parts.length < 2) continue;

                // JSON 형식 데이터 파싱
                String jsonString = parts[1];
                JSONObject json = new JSONObject(jsonString);

                String category = json.getString("category");
                if(!latestPowerData.containsKey(category)) continue;

                String iotId = json.getString("iot_id");
                if(latestPowerData.get(category).containsKey(iotId)) continue;

                Map<String, Object> iotData = new HashMap<>();
                iotData.put("name", json.getString("iot_name"));
                iotData.put("value", Float.parseFloat(json.getString("value")));

                latestPowerData.get(category).put(iotId, iotData);

            }
        } catch (Exception e) {
            log.error("Error reading log file", e);
            throw new RuntimeException(e);
        }

        // 각 기기의 최신 전력량 합산
        Float totalPower = latestPowerData.get("E").values().stream()
                .map(data -> (Float) data.get("value"))
                .reduce(0.0f, Float::sum);


        // 소수점 둘째 자리까지 포맷팅
        DecimalFormat df = new DecimalFormat("#.##");
        Float formattedTotalPower = Float.parseFloat(df.format(totalPower));

        // 결과 데이터를 반환 형식에 맞게 정리
        Map<String, Object> result = new HashMap<>();
        result.put("latestData", latestPowerData);
        result.put("totalPower", formattedTotalPower);

        return result;
    }
}
