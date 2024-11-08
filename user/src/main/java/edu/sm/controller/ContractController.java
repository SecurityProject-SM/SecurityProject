package edu.sm.controller;

import edu.sm.app.dto.ContractDto;
import edu.sm.app.service.ContractService;
import edu.sm.app.dto.UsersDto;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/contract")
public class ContractController {

    private final ContractService contractService;
    String dir = "contract/";

    @Autowired
    public ContractController(ContractService contractService) {
        this.contractService = contractService;
    }

    @RequestMapping("")
    public String viewContract(Model model, HttpSession session) throws Exception {
        // 세션에서 로그인된 사용자 정보 가져오기
        UsersDto usersDto = (UsersDto) session.getAttribute("loginid");
//        log.info("usersDto: {}", usersDto);
        if (usersDto != null) {
            String userId = usersDto.getUserId(); // 사용자 ID 추출

            // userId로 계약 정보를 가져옴
            ContractDto contractDto = contractService.getContractByUserId(userId);

            // 모델에 사용자와 계약 정보 추가
            model.addAttribute("user", usersDto);
            model.addAttribute("contractDto", contractDto);
        } else {
            // 로그인 정보가 없을 경우 처리 (예: 로그인 페이지로 리다이렉트)
            return "redirect:/login";
        }

        // left와 center JSP 설정
        model.addAttribute("left", dir + "left"); // left.jsp 파일을 가리킴
        model.addAttribute("center", dir + "center"); // center.jsp 파일을 가리킴

        return "index";
    }
}
