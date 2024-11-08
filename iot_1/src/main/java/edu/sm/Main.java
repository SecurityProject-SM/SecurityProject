package edu.sm;

import edu.sm.util.HttpSendData;
import org.json.simple.JSONObject;

import java.util.Random;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        String url = "http://127.0.0.1/iot/data";
        String buildingId = "B001";
        String floor = "3";
        String houseId = "H001";
        String iotId = "IOT1";
        String iotName = "에어컨";
//        String[] categories = {"T", "H", "B", "E"}; // T: 온도, H: 습도, B: 조도, E: 전력량
        String category = "E";
        String loc = "3층 사무실";



        Random r = new Random();
        for (int i = 0; i < 100; i++) {
            float value = r.nextFloat() * 100;  // 센서 측정 값

            // JSON 데이터 생성
            JSONObject jsonData = new JSONObject();
            jsonData.put("buildingId", buildingId);
            jsonData.put("floor", floor);
            jsonData.put("house_id", houseId);
            jsonData.put("iot_id", iotId);
            jsonData.put("iot_name", iotName);
            jsonData.put("category", category);
            jsonData.put("value", value);
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