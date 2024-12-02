package edu.sm.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.sm.app.dto.AvgTHDto;
import edu.sm.app.dto.IotDto;
import edu.sm.app.dto.IotHistoryDto;
import edu.sm.app.dto.RepairsDto;
import edu.sm.app.service.IotHistoryService;
import edu.sm.app.service.IotServcie;
import edu.sm.app.service.RepairsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/iot")
public class IotRestController {

    private static final String LOG_FILE_PATH = "C:\\SmartBuildingProject\\logs\\data.log";
    private final IotServcie iotService;
    private final IotHistoryService iotHistoryService;
    private final RepairsService repairsService;


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
            if (iotStatus.equals("1")) {
                if (valueCategory.equals("E") && iotValue >= 50) {
                    IotDto BreakIot = new IotDto();
                    BreakIot.setIotId(iotId);
                    BreakIot.setIotCategory(valueCategory);
                    BreakIot.setIotStatus("3");
                    iotService.modify(BreakIot);

                    String buildingId = jsonNode.get("building_id").asText();
                    String iotLoc = jsonNode.get("loc").asText();

                    log.info("제발 찍혀라 Building ID: {}, IoT Loc: {}", buildingId, iotLoc);
                    RepairsDto repairsDto = RepairsDto.builder()
                            .buildingId(buildingId)
                            .iotId(iotId)
                            .repairStat("A")
                            .repairLoc(iotLoc)
                            .build();
                    repairsService.add(repairsDto);
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
        } catch (Exception e) {
            log.error("Error processing Iot data", e);
            return "Error processing Iot data";
        }
//        return data;
    }


    // iot기기 제어 함수
    @RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
    public ResponseEntity<String> updateIotStatus(@RequestBody Map<String, String> request) {
        try {
            String iotId = request.get("iotId");
            String currentStatus = iotService.getIotStatusById(iotId);

            // 고장 상태인 경우
            if ("3".equals(currentStatus)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body("고장 상태인 기기는 제어할 수 없습니다.");
            }

            // 상태 변경 처리
            String newStatus = "1".equals(currentStatus) ? "2" : "1"; // 1 -> 2, 2 -> 1
            IotDto iotDto = new IotDto();
            iotDto.setIotId(iotId);
            iotDto.setIotStatus(newStatus);
            iotService.modify(iotDto);

            return ResponseEntity.ok("IoT 상태가 변경되었습니다.");
        } catch (Exception e) {
            log.error("Error updating IoT status", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("IoT 상태 변경 중 오류가 발생했습니다.");
        }
    }

    // IoT 상태 조회 API
    @RequestMapping("/getIotStatus")
    @ResponseBody
    public List<Map<String, Object>> getIotStatus() throws Exception {
        List<IotDto> iotList = iotService.get(); // IoT 상태 조회
        List<Map<String, Object>> result = new ArrayList<>();
        for (IotDto iot : iotList) {
            Map<String, Object> obj = new HashMap<>();
            obj.put("iotId", iot.getIotId());
            obj.put("iotStatus", iot.getIotStatus()); // 1:on 2:off 3:break
            result.add(obj);
        }
        return result;
    }

    @RequestMapping("/latestData2")
    public Map<String, Object> getLatestData2() throws Exception {
        Map<String, Map<String, Map<String, Object>>> latestPowerData = new HashMap<>();
        latestPowerData.put("T", new HashMap<>());
        latestPowerData.put("H", new HashMap<>());
        latestPowerData.put("E", new HashMap<>());

        List<IotHistoryDto> historyLatestData = iotHistoryService.selectLatestIotHistory();

        // 평균 습도 값 불러오기
        AvgTHDto avgTHData = iotHistoryService.selectAvgTH();

        for (IotHistoryDto data : historyLatestData) {
            String category = data.getValueCategory();
            if (!latestPowerData.containsKey(category)) continue;

            String iotId = data.getIotId();
            //        if(latestPowerData.get(category).containsKey(iotId)) continue;

            Map<String, Object> iotData = new HashMap<>();
            iotData.put("value", data.getIotValue());
            iotData.put("name", data.getIotName());
            iotData.put("id", iotId);
            iotData.put("status", data.getIotStatus());


            latestPowerData.get(category).put(iotId, iotData);
        }

        Float totalPower = latestPowerData.get("E").values().stream()
                .map(data -> (Float) ((Double) data.get("value")).floatValue())
                .reduce(0.0f, Float::sum);

        DecimalFormat df = new DecimalFormat("#.##");
        Float formattedTotalPower = Float.parseFloat(df.format(totalPower));

        Map<String, Object> result = new HashMap<>();
        result.put("latestData", latestPowerData);
        result.put("totalPower", formattedTotalPower);

        // 평균 온도와 습도 데이터를 Map에 추가
        Map<String, Object> avgData = new HashMap<>();
        avgData.put("avgTemperature", avgTHData.getAvgTemperature());
        avgData.put("avgHumidity", avgTHData.getAvgHumidity());
        result.put("avgData", avgData);

        return result;
    }

    @RequestMapping("/mainpage")
    public ResponseEntity<Double> getElec() throws Exception {
        double totalPower = iotHistoryService.getElec();
        return ResponseEntity.ok(totalPower);
    }

    @RequestMapping("/chartdata")
    public ResponseEntity<Map<String, Object>> getChartData() {
        try {
            Map<String, Object> chartData = iotHistoryService.chartdata();
            return ResponseEntity.ok(chartData);
        } catch (Exception e) {
            log.error("Error fetching chart data", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }


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


    @RequestMapping("/hum")
    public Double getCurrentHumidity() throws Exception {
        return iotHistoryService.getCurHum();
    }

    @RequestMapping("temp")
    public Double getCurrentTemperature() throws Exception {
        return iotHistoryService.getCurTemp();
    }
}
