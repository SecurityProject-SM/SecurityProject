package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.AdminsDto;
import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.Search;
import edu.sm.app.service.NoticeService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/notice")
public class NoticeController {

    final NoticeService noticeService;

    @RequestMapping("")
    public String notice(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo) {
        log.info("Loading notice list - page {}", pageNo);
        PageInfo<NoticeDto> pageInfo = new PageInfo<>(noticeService.getNoticePage(pageNo), 5); // 페이지네이션 설정
        model.addAttribute("cpage", pageInfo);
        model.addAttribute("center", "notice/notice");
        model.addAttribute("target", "notice");
        return "index";
    }

    // 검색 결과 및 페이징 처리
    @RequestMapping("/findimpl")
    public String findimpl(Model model, Search search,
                           @RequestParam(value = "pageNo", defaultValue = "1") int pageNo) throws Exception {
        log.info("Searching notices with keyword: {} and search term: {}", search.getKeyword(), search.getSearch());
        PageInfo<NoticeDto> pageInfo = new PageInfo<>(noticeService.getFindPage(pageNo, search), 5);
        model.addAttribute("cpage", pageInfo);

        model.addAttribute("target", "notice");
        model.addAttribute("search", search);
        model.addAttribute("center", "notice/notice");
        return "index";
    }

    @RequestMapping("/write")
    public String write(Model model, NoticeDto noticeDto) {
        model.addAttribute("center", "notice/write");
        return "index";
    }

    @RequestMapping("/writeimpl")
    public String writeimpl(Model model, NoticeDto noticeDto, HttpSession session,
                            @RequestParam("noticeName") String title,
                            @RequestParam("noticeDetail") String content) throws Exception {

        log.info("writeimpl 실행됨");

        AdminsDto adminsDto = (AdminsDto) session.getAttribute("loginid");
        if (adminsDto != null) {
            String adminId = adminsDto.getAdminId();
            noticeDto.setAdminId(adminId);
        }

        noticeDto.setNoticeName(title);
        noticeDto.setNoticeDetail(content);

        noticeService.add(noticeDto);

        return "redirect:/notice";
    }

}
