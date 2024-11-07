package edu.sm.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@EnableWebSocketMessageBroker
@Configuration
public class StomWebSocketConfig implements WebSocketMessageBrokerConfigurer{

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {

        //setAllowedOriginPatterns
        //어드민같은경우는 자기서버에서 ws서버에 접속한건데
        //user는 다른 서버에접속을 했지만 같은 ws에 접속할 수 있게한다
        //접속 되어있는 모든이에게
        registry.addEndpoint("/ws").setAllowedOriginPatterns("*").withSockJS();

        //관리자와 사용자 끼리만 통신한다
//        registry.addEndpoint("/chat").setAllowedOriginPatterns("*").withSockJS();

        //서버 어드민용
        registry.addEndpoint("/wss").setAllowedOriginPatterns("*").withSockJS();

        //iot 기기 통신용
        registry.addEndpoint("/iot/ws").setAllowedOriginPatterns("*").withSockJS();

//        127.0.0.1 만 허용하는것
//        registry.addEndpoint("/ws").setAllowedOrigins("http://127.0.0.1").withSockJS();
//        registry.addEndpoint("/chbot").setAllowedOrigins("http://127.0.0.1").withSockJS();
//        registry.addEndpoint("/wss").setAllowedOrigins("http://127.0.0.1").withSockJS();
    }

    /* 어플리케이션 내부에서 사용할 path를 지정할 수 있음 */
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/send", "/broadcast", "/control"); // IoT 제어용 경로 추가 /control
    }
}