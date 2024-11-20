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
        String category = "E";
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

        for (int i = 0; i < 100; i++) {

            for (int j = 0; j < iotIds.length; j++) {
                float value = 25.00f + r.nextFloat() * (32.00f - 25.00f); // 랜덤 값 생성
                String formattedValue = df.format(value);
                // JSON 데이터 생성
                JSONObject jsonData = new JSONObject();
                jsonData.put("buildingId", buildingId);
                jsonData.put("floor", floor);
                jsonData.put("house_id", houseId);
                jsonData.put("iot_id", iotIds[j]);
                jsonData.put("iot_name", iotNames[j]);
                jsonData.put("category", category);
                jsonData.put("value", formattedValue);
                jsonData.put("loc", locations[j]);

                // JSON 데이터 전송
                HttpSendData.send(url, jsonData.toString());
            }

            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
    }
}