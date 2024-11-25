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
        String buildingId = "B001";
        String floor = "3";
        String houseId = "H001";
        String[] category = {"E","T","H"};
        String[] iotIds = {"IOT1", "IOT2", "IOT3", "IOT4", "IOT5", "IOT6", "IOT7"};
        String[] iotNames = {"에어컨1", "에어컨2", "에어컨3", "에어컨4", "에어컨5", "에어컨6", "에어컨7"};
        String[] locations = {
                "건어물학원 강의실1",
                "건어물학원 강의실2",
                "건어물학원 강의실3",
                "건어물학원 강의실4",
                "건어물학원 강의실5",
                "건어물학원 강의실6",
                "건어물학원 강의실7"
        };
        Random r = new Random();
        DecimalFormat df = new DecimalFormat( "#.##");

        for (int i = 0; i < 20; i++) {

            // ======== 전력량 데이터 ========
            for (int j = 0; j < iotIds.length; j++) {
                float value = 25.00f + r.nextFloat() * 27.00f; // 랜덤 값 생성
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
            for (int j = 0; j < iotIds.length; j++) {
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
            for (int j = 0; j < iotIds.length; j++) {
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