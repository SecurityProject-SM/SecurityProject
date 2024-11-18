package edu.sm;

import edu.sm.util.HttpSendData;
import org.json.simple.JSONObject;

import java.text.DecimalFormat;
import java.util.Random;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        String url = "https://127.0.0.1:8443/iot/data";
        String buildingId = "B001";
        String floor = "3";
        String houseId = "H001";
        String iotId = "IOT1";
        String iotName = "에어컨";
//        String[] categories = {"T", "H", "B", "E"}; // T: 온도, H: 습도, B: 조도, E: 전력량
        String category = "E";
        String loc = "건어물학원 강의실1";

        Random r = new Random();
        for (int i = 0; i < 100; i++) {
            float value = 30.00f + r.nextFloat() * (32.00f - 30.00f);  // 센서 측정 값

            DecimalFormat df = new DecimalFormat("#.##");  // 소수점 둘째 자리까지 포맷 지정
            String formattedValue = df.format(value);

            // JSON 데이터 생성
            JSONObject jsonData = new JSONObject();
            jsonData.put("buildingId", buildingId);
            jsonData.put("floor", floor);
            jsonData.put("house_id", houseId);
            jsonData.put("iot_id", iotId);
            jsonData.put("iot_name", iotName);
            jsonData.put("category", category);
            jsonData.put("value", formattedValue);
            jsonData.put("loc", loc);

            // JSON 데이터 전송
            HttpSendData.send(url, jsonData.toString());

            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
    }
}