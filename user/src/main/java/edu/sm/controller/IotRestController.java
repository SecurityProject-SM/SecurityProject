package edu.sm.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.sm.app.dto.IotDto;
import edu.sm.app.dto.IotHistoryDto;
import edu.sm.app.service.IotHistoryService;
import edu.sm.app.service.IotServcie;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
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
    private final IotServcie iotService;
    private final IotHistoryService iotHistoryService;


    @RequestMapping("/data")
    public String receiveIoTData(@RequestBody String data) {
        try {
            log.info(data);

            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(data);

            String iotId = jsonNode.get("iot_id").asText();
            String iotName = jsonNode.get("iot_name").asText();
            String valueCategory = jsonNode.get("category").asText();
            double iotValue = jsonNode.get("value").asDouble();


            String iotStatus = iotService.getIotStatusById(iotId);
            if(iotStatus.equals("1")) {
                if (iotValue >= 50) {
                    IotDto BreakIot = new IotDto();
                    BreakIot.setIotId(iotId);
                    BreakIot.setIotCategory(valueCategory);
                    BreakIot.setIotStatus("3");
                    iotService.modify(BreakIot);
                }
            }
            // IOT 상태에 따라 DB에 들어갈 value값 지정
            // iot가 꺼져있으면 사용전력이 0이들어감
            if (!iotStatus.equals("1")) {
                iotValue = 0.0;
            }

            IotHistoryDto historyDto = IotHistoryDto.builder()
                    .iotId(iotId)
                    .iotName(iotName)
                    .valueCategory(valueCategory)
                    .iotValue(iotValue)
                    .iotStatus(iotStatus)
                    .logDate(LocalDateTime.now())
                    .build();
            iotHistoryService.add(historyDto);
            return "Data saved successfully";
        }catch(Exception e){
            log.error("Error processing Iot data", e);
            return "Error processing Iot data";
        }
//        return data;
    }


    // IoT 상태 조회 API
    @RequestMapping("/getIotStatus")
    @ResponseBody
    public List<Map<String,Object>> getIotStatus() throws Exception {
        List<IotDto> iotList = iotService.get(); // IoT 상태 조회
        List<Map<String,Object>> result = new ArrayList<>();
        for (IotDto iot : iotList) {
            Map<String,Object> obj = new HashMap<>();
            obj.put("iotId", iot.getIotId());
            obj.put("iotStatus", iot.getIotStatus()); // 1:on 2:off 3:break
            result.add(obj);
        }
        return result;
    }

    @RequestMapping("/latestData2")
    public Map<String,Object> getLatestData2() throws Exception {
        Map<String,Map<String,Map<String,Object>>> latestPowerData = new HashMap<>();
        latestPowerData.put("T", new HashMap<>());
        latestPowerData.put("H", new HashMap<>());
        latestPowerData.put("E", new HashMap<>());

        List<IotHistoryDto> historyLatestData = iotHistoryService.selectLatestIotHistory();

        for(IotHistoryDto data : historyLatestData){
            String category = data.getValueCategory();
            if(!latestPowerData.containsKey(category)) continue;

            String iotId = data.getIotId();
    //        if(latestPowerData.get(category).containsKey(iotId)) continue;

            Map<String, Object> iotData = new HashMap<>();
            iotData.put("value", data.getIotValue());
            iotData.put("name",data.getIotName());
            iotData.put("id", iotId);


            latestPowerData.get(category).put(iotId, iotData);
        }

        Float totalPower = latestPowerData.get("E").values().stream()
                .map(data -> (Float) ((Double) data.get("value")).floatValue())
                .reduce(0.0f,Float::sum);

        DecimalFormat df = new DecimalFormat("#.##");
        Float formattedTotalPower = Float.parseFloat(df.format(totalPower));

        Map<String, Object> result = new HashMap<>();
        result.put("latestData",latestPowerData);
        result.put("totalPower",formattedTotalPower);

        return result;
    }

    //테이블에 뿌리는 코드 (로그에서 읽는 코드)
//    @RequestMapping("/latestData")
//    public Map<String, Object> getLatestData() {
//        Map<String,Map<String, Map<String,Object>>> latestPowerData = new HashMap<>();
//        latestPowerData.put("T", new HashMap<>());
//        latestPowerData.put("H", new HashMap<>());
//        latestPowerData.put("E", new HashMap<>());
//
//        File file = new File(LOG_FILE_PATH);
//        try (ReversedLinesFileReader br = new ReversedLinesFileReader(file)) {
//            String line;
//            while ((line = br.readLine()) != null) {
//                String[] parts = line.split(", ", 2);
//                if (parts.length < 2) continue;
//
//                // JSON 형식 데이터 파싱
//                String jsonString = parts[1];
//                JSONObject json = new JSONObject(jsonString);
//
//                String category = json.getString("category");
//                if(!latestPowerData.containsKey(category)) continue;
//
//                String iotId = json.getString("iot_id");
//                if(latestPowerData.get(category).containsKey(iotId)) continue;
//
//                Map<String, Object> iotData = new HashMap<>();
//                iotData.put("name", json.getString("iot_name"));
//                iotData.put("value", Float.parseFloat(json.getString("value")));
//
//                latestPowerData.get(category).put(iotId, iotData);
//
//            }
//        } catch (Exception e) {
//            log.error("Error reading log file", e);
//            throw new RuntimeException(e);
//        }
//
//        // 각 기기의 최신 전력량 합산
//        Float totalPower = latestPowerData.get("E").values().stream()
//                .map(data -> (Float) data.get("value"))
//                .reduce(0.0f, Float::sum);
//
//
//        // 소수점 둘째 자리까지 포맷팅
//        DecimalFormat df = new DecimalFormat("#.##");
//        Float formattedTotalPower = Float.parseFloat(df.format(totalPower));
//
//        // 결과 데이터를 반환 형식에 맞게 정리
//        Map<String, Object> result = new HashMap<>();
//        result.put("latestData", latestPowerData);
//        result.put("totalPower", formattedTotalPower);
//
//        return result;
//    }

    @RequestMapping("/mainpage")
    public ResponseEntity<Double> getElec() throws Exception {
        double totalPower = iotHistoryService.getElec();
        return ResponseEntity.ok(totalPower);
    }

}
