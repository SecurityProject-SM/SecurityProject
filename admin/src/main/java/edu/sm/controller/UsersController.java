package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.AdminsDto;
import edu.sm.app.dto.Search;
import edu.sm.app.dto.UsersDto;
import edu.sm.app.service.UsersService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/users")
public class UsersController {

    final UsersService usersService;

    @RequestMapping("")
    public String notice(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo) {
        log.info("Loading notice list - page {}", pageNo);
        PageInfo<UsersDto> pageInfo = new PageInfo<>(usersService.getUsersPage(pageNo), 5); // 페이지네이션 설정
        model.addAttribute("cpage", pageInfo);
        model.addAttribute("center", "users/users");
        model.addAttribute("target", "users");
        return "index";
    }

    @RequestMapping("/findimpl")
    public String findimpl(Model model, Search search,
                           @RequestParam(value = "pageNo", defaultValue = "1") int pageNo) throws Exception {
        log.info("Searching users by name with search term: {}", search.getSearch());
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
                             @RequestParam("userTel") String userTel) throws Exception {


        return "redirect:/notice";
    }





}
