package edu.sm;

import edu.sm.util.HttpSendData;
import org.json.simple.JSONObject;

import java.text.DecimalFormat;
import java.util.Random;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        String url = "http://127.0.0.1/iot/data";
//        String url = "http://210.119.34.211:81/iot/data";
        String buildingId = "B001";
        String floor = "3";
        String houseId = "H001";
        String[] category = {"E","T","H"};
        String[] iotIds = {"IOT1", "IOT2", "IOT3", "IOT4", "IOT5", "IOT6", "IOT7", "IOT8", "IOT9", "IOT10", "IOT11", "IOT12", "IOT13", "IOT14", "IOT15"};
        String[] iotNames = {"에어컨1", "에어컨2", "에어컨3", "에어컨4", "에어컨5", "에어컨6", "에어컨7", "조명1", "조명2", "조명3", "조명4", "조명5", "조명6", "조명7", "조명8"};
        String[] locations = {
                "원장실",
                "건어물학원 강의실1",
                "건어물학원 강의실2",
                "건어물학원 강의실3",
                "건어물학원 강의실4",
                "건어물학원 강의실5",
                "건어물학원 강의실6",
                "로비",
                "원장실",
                "건어물학원 강의실2",
                "건어물학원 강의실1",
                "건어물학원 강의실3",
                "건어물학원 강의실4",
                "건어물학원 강의실5",
                "건어물학원 강의실6",
        };
        Random r = new Random();
        DecimalFormat df = new DecimalFormat( "#.##");

        for (int i = 0; i < 30; i++) {

            // ======== 전력량 데이터 ========
            for (int j = 0; j < iotIds.length; j++) {
                float value;
                // 에어컨인지 조명인지에 따라 값 범위 설정
                if (iotNames[j].contains("에어컨")) {
                    value = 5.00f + r.nextFloat() * 5.00f; // 5 ~ 10 사이의 값
                } else if (iotNames[j].contains("조명")) {
                    value = 1.00f + r.nextFloat() * 1.00f; // 1 ~ 2 사이의 값
                } else {
                    value = 25.00f + r.nextFloat() * 24.00f; // 기본 범위 (기타 장치)
                }
                String formattedValue = df.format(value);
                // JSON 데이터 생성
                JSONObject jsonData = new JSONObject();
                jsonData.put("building_id", buildingId);
                jsonData.put("floor", floor);
                jsonData.put("house_id", houseId);
                jsonData.put("iot_id", iotIds[j]);
                jsonData.put("iot_name", iotNames[j]);
                jsonData.put("category", category[0]);
                jsonData.put("value", formattedValue);
                jsonData.put("loc", locations[j]);

                // JSON 데이터 전송
                HttpSendData.send(url, jsonData.toString());
            }

            // ======== 온도 데이터 ========
            for (int j = 0; j < 7; j++) {
                float value = 21.00f + r.nextFloat() * 3.00f; // 랜덤 값 생성
                DecimalFormat dfT = new DecimalFormat( "#.#");
                String formattedValue = dfT.format(value);
                // JSON 데이터 생성
                JSONObject jsonData = new JSONObject();
                jsonData.put("building_id", buildingId);
                jsonData.put("floor", floor);
                jsonData.put("house_id", houseId);
                jsonData.put("iot_id", iotIds[j]);
                jsonData.put("iot_name", iotNames[j]);
                jsonData.put("category", category[1]);
                jsonData.put("value", formattedValue);
                jsonData.put("loc", locations[j]);

                // JSON 데이터 전송
                HttpSendData.send(url, jsonData.toString());
            }

            // ======== 습도 데이터 ========
            for (int j = 0; j < 7; j++) {
                float value = 43.00f + r.nextFloat() * 10.00f; // 랜덤 값 생성
                DecimalFormat dfH = new DecimalFormat( "#");
                String formattedValue = dfH.format(value);
                // JSON 데이터 생성
                JSONObject jsonData = new JSONObject();
                jsonData.put("building_id", buildingId);
                jsonData.put("floor", floor);
                jsonData.put("house_id", houseId);
                jsonData.put("iot_id", iotIds[j]);
                jsonData.put("iot_name", iotNames[j]);
                jsonData.put("category", category[2]);
                jsonData.put("value", formattedValue);
                jsonData.put("loc", locations[j]);

                // JSON 데이터 전송
                HttpSendData.send(url, jsonData.toString());
            }

            try {
                Thread.sleep(3000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
    }
}