package edu.sm.controller;

import edu.sm.app.dto.PaymentRequestDto;
import edu.sm.app.service.ParkService;
import edu.sm.app.service.PaymentCalculationService;
import edu.sm.app.service.PortOneClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/park")
@RequiredArgsConstructor
public class ParkController {
    String dir = "park/";

    private final ParkService parkService;

    @RequestMapping("")
    public String item(Model model){
        model.addAttribute("center", dir+"center");
        return "index";
    }

    @RequestMapping("/calc")
    public String calc(Model model) {
        log.info("calc run");
        model.addAttribute("center", "park/calc");
        return "index";
    }

    private final PaymentCalculationService calculationService;
    private final PortOneClient portOneClient;

    @PostMapping("/calculate-and-pay")
    public ResponseEntity<String> calculateAndRequestPayment(@RequestBody PaymentRequestDto requestDto) {
        try {
            // 결제 금액 계산
            int amount = calculationService.calculateAmount(requestDto);
            log.info("Calculated amount: {}", amount);

            // 결제 요청
            String merchantUid = "order_" + System.currentTimeMillis(); // 유니크한 주문 ID 생성
            String response = portOneClient.requestPayment(merchantUid, amount);

            return ResponseEntity.ok("Payment requested successfully. Response: " + response);
        } catch (Exception e) {
            log.error("Error in calculate and pay: {}", e.getMessage());
            return ResponseEntity.status(500).body("Error: " + e.getMessage());
        }
    }

}
