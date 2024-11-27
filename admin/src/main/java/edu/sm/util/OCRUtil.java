package edu.sm.util;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class OCRUtil {
    public static JSONObject getResult(String apiurl, String secretkey, String imgpath, String imgname){
        JSONObject obj = null;

//        String apiURL = "https://ob9suhs003.apigw.ntruss.com/custom/v1/36176/31fcaecf61b9c9d3f441fa84010a9294091541d126ab198f900dd5064598ce70/infer";
//        String secretKey = "bnJhUnR5WlpSYlluR1FXTFBLU29tSEZwUWJvYVlkSHE=";

        String apiURL = apiurl;
        String secretKey = secretkey;
        String imageFile = imgpath+imgname;

        try {
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setReadTimeout(30000);
            con.setRequestMethod("POST");
            String boundary = "----" + UUID.randomUUID().toString().replaceAll("-", "");
            con.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
            con.setRequestProperty("X-OCR-SECRET", secretKey);

            JSONObject json = new JSONObject();
            json.put("version", "V2");
            json.put("requestId", UUID.randomUUID().toString());
            json.put("timestamp", System.currentTimeMillis());
            JSONObject image = new JSONObject();
            image.put("format", "jpg");
            image.put("name", "demo");
            JSONArray images = new JSONArray();
            images.add(image);
            json.put("images", images);
            String postParams = json.toString();

            con.connect();
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            long start = System.currentTimeMillis();
            File file = new File(imageFile);
            writeMultiPart(wr, postParams, file, boundary);
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) {
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            JSONParser parser = new JSONParser();
            obj = (JSONObject) parser.parse(response.toString());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
        }

        return obj;
    }

    private static void writeMultiPart(OutputStream out, String jsonMessage, File file, String boundary) throws
            IOException {
        StringBuilder sb = new StringBuilder();
        sb.append("--").append(boundary).append("\r\n");
        sb.append("Content-Disposition:form-data; name=\"message\"\r\n\r\n");
        sb.append(jsonMessage);
        sb.append("\r\n");

        out.write(sb.toString().getBytes("UTF-8"));
        out.flush();

        if (file != null && file.isFile()) {
            out.write(("--" + boundary + "\r\n").getBytes("UTF-8"));
            StringBuilder fileString = new StringBuilder();
            fileString
                    .append("Content-Disposition:form-data; name=\"file\"; filename=");
            fileString.append("\"" + file.getName() + "\"\r\n");
            fileString.append("Content-Type: application/octet-stream\r\n\r\n");
            out.write(fileString.toString().getBytes("UTF-8"));
            out.flush();

            try (FileInputStream fis = new FileInputStream(file)) {
                byte[] buffer = new byte[8192];
                int count;
                while ((count = fis.read(buffer)) != -1) {
                    out.write(buffer, 0, count);
                }
                out.write("\r\n".getBytes());
            }

            out.write(("--" + boundary + "--\r\n").getBytes("UTF-8"));
        }
        out.flush();
    }

//    public static Map getData(JSONObject obj){
////        Map<String,String> map = new HashMap<>();
//        Map<Integer,String> map = new HashMap<>();
//        JSONArray images = (JSONArray) obj.get("images");
//        JSONObject jo1 = (JSONObject) images.get(0);
//        JSONArray fields = (JSONArray) jo1.get("fields");
//
//        // fields 배열 전체를 처리
//        for (int i = 0; i < fields.size(); i++) {
//            JSONObject fieldObj = (JSONObject) fields.get(i);
//            String inferText = (String) fieldObj.get("inferText");
//            map.put(i, inferText); // 인덱스를 키로 사용
//        }
//
////        @@기존 코드@@
////        JSONObject biznum_obj = (JSONObject) fields.get(0);
////        String biznum = (String)biznum_obj.get("inferText");
//
////        JSONObject bizname_obj = (JSONObject) fields.get(0);
////        String bizname = (String)bizname_obj.get("inferText");
////
////        JSONObject bizowner_obj = (JSONObject) fields.get(1);
////        String bizowner = (String)bizowner_obj.get("inferText");
////
////        JSONObject bizdate_obj = (JSONObject) fields.get(2);
////        String bizdate = (String)bizdate_obj.get("inferText");
////
////        JSONObject bizadd_obj = (JSONObject) fields.get(3);
////        String bizadd = (String)bizadd_obj.get("inferText");
////
//////        map.put("biznum", biznum);
////        map.put("bizname", bizname);
////        map.put("bizowner", bizowner);
////        map.put("bizdate", bizdate);
////        map.put("bizadd", bizadd);
//
////        // 크기 확인 후 데이터 처리
////        if (fields.size() > 0) {
////            JSONObject bizname_obj = (JSONObject) fields.get(0);
////            String bizname = (String) bizname_obj.get("inferText");
////            map.put("bizname", bizname);
////        }
////
////        if (fields.size() > 1) {
////            JSONObject bizowner_obj = (JSONObject) fields.get(1);
////            String bizowner = (String) bizowner_obj.get("inferText");
////            map.put("bizowner", bizowner);
////        }
////
////        if (fields.size() > 2) {
////            JSONObject bizdate_obj = (JSONObject) fields.get(2);
////            String bizdate = (String) bizdate_obj.get("inferText");
////            map.put("bizdate", bizdate);
////        }
////
////        if (fields.size() > 3) {
////            JSONObject bizadd_obj = (JSONObject) fields.get(3);
////            String bizadd = (String) bizadd_obj.get("inferText");
////            map.put("bizadd", bizadd);
////        }
//
//
//
//        return map;
//    }

//json데이터의 linBreak(줄바꿈) 데이터 값을 읽어서
//true가 나올때까지 반복해서 stringbuilder에 append로 추가하다가
//true가 나오면 거기까지 추가했던 stringbuilder 값을 리스트에 추가
//이러면 68가 / 5673 이렇게 따로 객체로 출력되는 애들을 한 줄로 병합 가능
//그후, 리스트의 값들을 정규표현식 pattern 매칭해서 [2~3자리 숫자][1자리 한글][4자리 숫자]
//정규식에 해당하는 데이터만 뽑아 냄, 이로써 차 모델명, 브랜드명 등등의 쓸데없는 값들은 불러오지 않을 수 있음
public static String getCarNumber(JSONObject obj) {
    JSONArray images = (JSONArray) obj.get("images");
    JSONObject jo1 = (JSONObject) images.get(0);
    JSONArray fields = (JSONArray) jo1.get("fields");

    StringBuilder currentLine = new StringBuilder(); // 현재 줄 병합
    List<String> mergedLines = new ArrayList<>();    // 병합된 줄 저장

    // fields 배열 순회
    for (int i = 0; i < fields.size(); i++) {
        JSONObject fieldObj = (JSONObject) fields.get(i);
        String inferText = (String) fieldObj.get("inferText");
        boolean lineBreak = (boolean) fieldObj.get("lineBreak");

        currentLine.append(inferText); // 현재 텍스트 병합

        if (lineBreak) {
            mergedLines.add(currentLine.toString()); // 한 줄 저장
            currentLine.setLength(0); // 초기화
        }
    }

    // 마지막 줄 추가
    if (currentLine.length() > 0) {
        mergedLines.add(currentLine.toString());
    }

    // 정규 표현식을 사용해 차량 번호 추출
    String carNumberPattern = "\\d{2,3}[가-힣]\\s?\\d{4}"; // 차량 번호 패턴
    Pattern pattern = Pattern.compile(carNumberPattern);

    for (String line : mergedLines) {
        Matcher matcher = pattern.matcher(line);
        if (matcher.find()) {
            return matcher.group(); // 첫 번째로 매칭된 차량 번호 반환
        }
    }

    return null; // 차량 번호를 찾지 못한 경우
}


}
