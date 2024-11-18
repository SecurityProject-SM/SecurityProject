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
        UsersDto usersDto = (UsersDto) session.getAttribute("loginid");
        if (usersDto != null) {
            String userId = usersDto.getUserId(); // 사용자 ID 추출

            ContractDto contractDto = contractService.getContractByUserId(userId);

            model.addAttribute("user", usersDto);
            model.addAttribute("contractDto", contractDto);
            session.setAttribute("contract", contractDto);
        } else {
            return "redirect:/login";
        }

        model.addAttribute("center", dir + "center");

        return "index";
    }
}