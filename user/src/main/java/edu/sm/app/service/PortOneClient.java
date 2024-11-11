package edu.sm.app.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class PortOneClient {

    private final String apiKey;
    private final String apiSecret;
    private final String channelKey; // 채널 키 추가
    private final RestTemplate restTemplate = new RestTemplate();

    public PortOneClient(
            @Value("${app.portone.api-key}") String apiKey,
            @Value("${app.portone.api-secret}") String apiSecret,
            @Value("${app.portone.channel-key}") String channelKey) { // 채널 키 주입
        this.apiKey = apiKey;
        this.apiSecret = apiSecret;
        this.channelKey = channelKey;
    }

    // 결제 요청 메서드
    public String requestPayment(String merchantUid, int amount) {
        String url = "https://api.iamport.kr/payments/request"; // 포트원 결제 요청 URL

        String accessToken = getAccessToken();

        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("merchant_uid", merchantUid); // 상점 주문 ID
        requestBody.put("amount", amount); // 결제 금액
        requestBody.put("name", "Parking Fee"); // 결제 이름
        requestBody.put("buyer_name", "사용자 이름"); // 사용자 이름
        requestBody.put("channel_key", channelKey); // 채널 키 추가

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);

        if (response.getStatusCode() == HttpStatus.OK) {
            Map<String, Object> responseBody = response.getBody();
            log.info("Payment request response: {}", responseBody);

            // 결제 요청 결과를 반환
            return (String) responseBody.get("response");
        } else {
            throw new RuntimeException("Payment request failed: " + response.getBody());
        }
    }

    // 액세스 토큰 발급 메서드
    private String getAccessToken() {
        String url = "https://api.iamport.kr/users/getToken";

        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("imp_key", apiKey);
        requestBody.put("imp_secret", apiSecret);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, String>> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);

        if (response.getStatusCode() == HttpStatus.OK) {
            Map<String, Object> responseBody = response.getBody();
            Map<String, String> responseData = (Map<String, String>) responseBody.get("response");
            return responseData.get("access_token");
        } else {
            throw new RuntimeException("Failed to get access token. Response: " + response.getBody());
        }
    }
}
