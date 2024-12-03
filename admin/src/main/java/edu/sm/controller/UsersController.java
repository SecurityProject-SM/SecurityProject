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

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/users")
public class UsersController {

    final UsersService usersService;
    final GhtlfService ghtlfService;

    @RequestMapping("")
    public String notice(Model model) throws Exception {
        List<GhtlfDto> ghtlfList = ghtlfService.get();
        model.addAttribute("ghtlf", ghtlfList);
        model.addAttribute("center", "users/users");
        return "index";
    }



    @RequestMapping("/findimpl")
    public String findimpl(Model model, Search search,
                           @RequestParam(value = "pageNo", defaultValue = "1") int pageNo) throws Exception {
        log.info("Searching users by name with search term: {}", search);
        PageInfo<UsersDto> pageInfo = new PageInfo<>(usersService.getFindPage(pageNo, search), 10);

        model.addAttribute("cpage", pageInfo);
        model.addAttribute("search", search); // 검색어를 유지하기 위해 전달
        model.addAttribute("target", "users");
        model.addAttribute("center", "users/users");
        return "index";
    }

    @RequestMapping("/detail")
    public String detail(Model model, @RequestParam("id") String id) throws Exception {
        UsersDto usersDto = null;
        usersDto = usersService.get(id);

        model.addAttribute("users", usersDto);
        model.addAttribute("center", "users/detail");

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
