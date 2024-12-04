package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.AdminsDto;
import edu.sm.app.dto.GhtlfDto;
import edu.sm.app.dto.Search;
import edu.sm.app.dto.UsersDto;
import edu.sm.app.service.GhtlfService;
import edu.sm.app.service.UsersService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/users")
public class UsersController {

    final UsersService usersService;
    final GhtlfService ghtlfService;

//    @RequestMapping("")
//    public String notice(Model model) throws Exception {
//        List<GhtlfDto> ghtlfList = ghtlfService.get();
//
//        List<GhtlfDto> sortedGhtlfList = ghtlfList.stream()
//                .sorted((a, b) -> Integer.compare(b.getRoom(), a.getRoom())) // 내림차순 정렬
//                .collect(Collectors.toList());
//
//        model.addAttribute("ghtlf", sortedGhtlfList);
//        model.addAttribute("center", "users/users");
//
//        return "index"; // 뷰 이름 반환
//    }

    @RequestMapping("")
    public String notice(Model model) throws Exception {
        List<GhtlfDto> ghtlfList = ghtlfService.get();

        Map<Integer, List<GhtlfDto>> groupedByFloor = ghtlfList.stream()
                .collect(Collectors.groupingBy(item -> item.getRoom() / 100)); // 층 계산

        List<Map.Entry<Integer, List<GhtlfDto>>> floors = groupedByFloor.entrySet().stream()
                .sorted((a, b) -> b.getKey().compareTo(a.getKey())) // 내림차순 정렬
                .collect(Collectors.toList());

        model.addAttribute("ghtlf", floors); // 정렬된 데이터를 ghtlf로 전달
        model.addAttribute("center", "users/users");

        return "index";
    }


    @RequestMapping("/detail")
    public String detail(Model model, @RequestParam("ghtlfid") Integer id) throws Exception {
        GhtlfDto ghtlfDto = null;
        ghtlfDto = ghtlfService.get(id);

        model.addAttribute("ghtlf", ghtlfDto);
        model.addAttribute("center", "users/detail");

        return "index";
    }

    @RequestMapping("/detailud")
    public String detail2(Model model, @RequestParam("ghtlfid") Integer id) throws Exception {
        GhtlfDto ghtlfDto = null;
        ghtlfDto = ghtlfService.get(id);

        model.addAttribute("ghtlf", ghtlfDto);
        model.addAttribute("center", "users/detailud");

        return "index";
    }

    @RequestMapping("/updateimpl")
    public String updateimpl(Model model, UsersDto usersDto,
                             @RequestParam("userPwd") String userPwd,
                             @RequestParam("userTel") String userTel,
                             @RequestParam("userMail") String userMaiil,
                             @RequestParam("userName") String userName) throws Exception {

        usersDto.setUserPwd(userPwd);
        usersDto.setUserTel(userTel);
        usersDto.setUserMail(userMaiil);
        usersDto.setUserName(userName);

        usersService.modify(usersDto);

        return "redirect:/users";
    }

    @RequestMapping("/deleteimpl")
    public String deleteimpl(Model model, UsersDto usersDto,
                             @RequestParam("userPwd") String userPwd,
                             @RequestParam("userTel") String userTel,
                             @RequestParam("userMail") String userMaiil,
                             @RequestParam("userName") String userName) throws Exception {

        usersDto.setUserPwd(userPwd);
        usersDto.setUserTel(userTel);
        usersDto.setUserMail(userMaiil);
        usersDto.setUserName(userName);

        usersService.modify(usersDto);

        return "redirect:/users";
    }


}
