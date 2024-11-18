//package edu.sm.config;
//
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//
//public class IoTWebSocketHandler extends TextWebSocketHandler {
//
//    private static final Logger log = LoggerFactory.getLogger(IoTWebSocketHandler.class);
//
//    @Override
//    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//        String payload = message.getPayload();
//        log.info("Received IoT Data: {}", payload);
//        session.sendMessage(new TextMessage("Acknowledged: " + payload)); // 클라이언트로 응답 메시지 전송
//    }
//}