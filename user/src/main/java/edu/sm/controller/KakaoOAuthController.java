package edu.sm.controller;

import edu.sm.app.dto.UsersDto;
import edu.sm.app.service.UsersService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

@Controller
@Slf4j
@RequiredArgsConstructor
public class KakaoOAuthController {


    private final UsersService usersService;

    @Value("${app.kakao.client-id}")
    private String clientId;

    @Value("${app.kakao.redirect-uri}")
    private String redirectUri;

    @Value("${app.kakao.token-uri}")
    private String tokenUri;

    @Value("${app.kakao.user-info-uri}")
    private String userInfoUri;

    @RequestMapping("/oauth/kakao")
    public String kakaoLogin() {
        String url = "https://kauth.kakao.com/oauth/authorize?client_id=" + clientId + "&redirect_uri=" + redirectUri + "&response_type=code";
        return "redirect:" + url;
    }

    @GetMapping("/oauth/kakao/callback")
    public String kakaoCallback(@RequestParam("code") String code, HttpSession session) throws Exception {
        RestTemplate restTemplate = new RestTemplate();

        // Step 1: Access Token 요청
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        String bodyData = "grant_type=authorization_code" +
                "&client_id=" + clientId +
                "&redirect_uri=" + redirectUri +
                "&code=" + code;

        HttpEntity<String> requestEntity = new HttpEntity<>(bodyData, headers);
        ResponseEntity<String> response = restTemplate.postForEntity(tokenUri, requestEntity, String.class);

        // Access Token 추출
        JSONObject jsonObj = new JSONObject(response.getBody());
        String accessToken = jsonObj.getString("access_token");

        // Step 2: Access Token으로 사용자 정보 요청
        headers.clear();
        headers.add("Authorization", "Bearer " + accessToken);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> userInfoResponse = restTemplate.exchange(userInfoUri, HttpMethod.GET, entity, String.class);
        JSONObject userInfo = new JSONObject(userInfoResponse.getBody());

        // 사용자 정보 추출
        String kakaoId = userInfo.get("id").toString();
        String kakaoNickname = userInfo.getJSONObject("properties").getString("nickname");

        // DB에 해당 카카오 ID의 사용자 존재 여부 확인
        UsersDto usersDto = usersService.findByKakaoId(kakaoId);

        // 기존 사용자 없으면 새로운 사용자 정보 저장
        if (usersDto == null) {
            usersDto = UsersDto.builder()
                    .userId(kakaoId)           // 카카오 ID를 user_id로 사용
                    .userName(kakaoNickname)   // 카카오 닉네임을 user_name으로 사용
                    .build();

            usersService.addKakaoUser(usersDto); // 새로운 사용자 저장

            // 세션에 사용자 정보 저장
            session.setAttribute("loginid", usersDto);

            // 추가 정보 입력 페이지로 리다이렉트
            return "redirect:/additional-info";
        }

        // 기존 사용자인 경우 메인 페이지로 리다이렉트
        session.setAttribute("loginid", usersDto);
        return "redirect:/";
    }
}
