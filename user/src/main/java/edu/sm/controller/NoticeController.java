package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.Search;
import edu.sm.app.service.NoticeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/notice")
public class NoticeController {

    private final NoticeService noticeService;

    // 공지사항 기본 목록 페이지 (첫 페이지 로드)
    @GetMapping("")
    public String notice(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo) {
        log.info("Loading notice list - page {}", pageNo);
        PageInfo<NoticeDto> pageInfo = new PageInfo<>(noticeService.getNoticePage(pageNo), 5); // 페이지네이션 설정
        model.addAttribute("cpage", pageInfo);
        model.addAttribute("center", "notice/notice");
        model.addAttribute("target", "notice");
        return "index";
    }

    // 검색 결과 및 페이징 처리
    @GetMapping("/findimpl")
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

    @RequestMapping("/detail")
    public String detail(Model model, @RequestParam("id") int id) throws Exception {
        NoticeDto noticeDto = null;
        noticeDto = noticeService.get(id);

        model.addAttribute("notice", noticeDto);
        model.addAttribute("center", "notice/detail");

        return "index";
    }
}
