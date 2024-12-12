package edu.sm.util;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.Date;

public class ChatBotUtil {

    public static String getMsg(String apiUrl, String secretKey, String msg) throws Exception {
        URL url = new URL(apiUrl);
        String chatMessage = msg;
        String message =  getReqMessage(chatMessage);
        String encodeBase64String = makeSignature(message, secretKey);
//        System.out.println(message);
//        System.out.println(encodeBase64String);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json;UTF-8");
        con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());

        wr.write(message.getBytes("UTF-8"));
        wr.flush();
        wr.close();
        int responseCode = con.getResponseCode();
//        System.out.println("responseCode:"+responseCode);

        BufferedReader br;

        if(responseCode==200) { // 정상 호출

            BufferedReader in = new BufferedReader(
                    new InputStreamReader(
                            con.getInputStream()));
            String decodedString;
            String jsonString = "";
            while ((decodedString = in.readLine()) != null) {
                jsonString = decodedString;
            }
            //chatbotMessage = decodedString;

            JSONParser jsonparser = new JSONParser();
            try {

                JSONObject json = (JSONObject)jsonparser.parse(jsonString);
                JSONArray bubblesArray = (JSONArray)json.get("bubbles");
                JSONObject bubbles = (JSONObject)bubblesArray.get(0);
                JSONObject data = (JSONObject)bubbles.get("data");
                String description = "";
                description = (String)data.get("description");
                chatMessage = description;
            } catch (Exception e) {
                System.out.println("error");
                e.printStackTrace();
            }

            in.close();

        } else {  // 에러 발생
            System.out.println("Error");

            chatMessage = con.getResponseMessage();
        }
        return chatMessage;
    }

    public static String getReqMessage(String voiceMessage) {

        String requestBody = "";

        try {

            JSONObject obj = new JSONObject();

            long timestamp = new Date().getTime();

            System.out.println("##"+timestamp);

            obj.put("version", "v2");
            obj.put("userId", "U47b00b58c90f8e47428af8b7bddc1231heo2");
            obj.put("timestamp", timestamp);

            JSONObject bubbles_obj = new JSONObject();

            bubbles_obj.put("type", "text");

            JSONObject data_obj = new JSONObject();
            data_obj.put("description", voiceMessage);

            bubbles_obj.put("type", "text");
            bubbles_obj.put("data", data_obj);

            JSONArray bubbles_array = new JSONArray();
            bubbles_array.add(bubbles_obj);

            obj.put("bubbles", bubbles_array);
            obj.put("event", "send");

            requestBody = obj.toString();

        } catch (Exception e){
            System.out.println("## Exception : " + e);
        }

        return requestBody;

    }
    public static String makeSignature(String message, String secretKey) {

        String encodeBase64String = "";

        try {
            byte[] secrete_key_bytes = secretKey.getBytes("UTF-8");

            SecretKeySpec signingKey = new SecretKeySpec(secrete_key_bytes, "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);

            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);

            return encodeBase64String;

        } catch (Exception e){
            System.out.println(e);
        }

        return encodeBase64String;

    }

    public static String getMsgUrl(String apiUrl, String secretKey, String msg) throws Exception {
        URL url = new URL(apiUrl); // 여기서 URL 객체 변수 url이 이미 선언됨
        String chatMessage = msg;
        String message = getReqMessage(chatMessage);
        String encodeBase64String = makeSignature(message, secretKey);

        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json;UTF-8");
        con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);
        con.setDoOutput(true);

        try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
            wr.write(message.getBytes("UTF-8"));
            wr.flush();
        }

        int responseCode = con.getResponseCode();
        System.out.println("Response Code: " + responseCode);

        if (responseCode == 200) {
            try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
                StringBuilder jsonString = new StringBuilder();
                String decodedString;
                while ((decodedString = in.readLine()) != null) {
                    jsonString.append(decodedString);
                }

                System.out.println("Raw JSON Response: " + jsonString);

                // Parse JSON
                JSONParser jsonparser = new JSONParser();
                JSONObject json = (JSONObject) jsonparser.parse(jsonString.toString());

                // Extract bubbles
                JSONArray bubbles = (JSONArray) json.get("bubbles");
                if (bubbles == null || bubbles.isEmpty()) {
                    return "Default response: No information found in the response.";
                }

                JSONObject firstBubble = (JSONObject) bubbles.get(0);
                JSONObject bubbleData = (JSONObject) firstBubble.get("data");
                if (bubbleData == null) {
                    return "Default response: Missing data in bubbles.";
                }

                // Extract description and URL
                String description = (String) bubbleData.get("description");
                String linkUrl = (String) bubbleData.get("url"); // 변수 이름을 linkUrl로 변경

                // Combine description and URL
                StringBuilder finalMessage = new StringBuilder();
                if (description != null) {
                    finalMessage.append(description);
                }
                if (linkUrl != null) {
                    finalMessage.append("\nLink: ").append(linkUrl);
                }

                chatMessage = finalMessage.toString();
                System.out.println("Parsed Response: " + chatMessage);
            }
        } else {
            chatMessage = "Error: " + con.getResponseMessage();
        }

        return chatMessage;
    }
}