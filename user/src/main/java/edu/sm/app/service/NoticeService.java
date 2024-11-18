package edu.sm.app.service;

import com.github.pagehelper.PageHelper;
import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.ParkDto;
import edu.sm.app.dto.Search;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.NoticeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class NoticeService implements SBService<Integer, NoticeDto> {

    final NoticeRepository noticeRepository;

    @Override
    public void add(NoticeDto noticeDto) throws Exception {
        noticeRepository.insert(noticeDto);
    }

    @Override
    public void modify(NoticeDto noticeDto) throws Exception {
        noticeRepository.update(noticeDto);
    }

    @Override
    public void del(Integer integer) throws Exception {
        noticeRepository.delete(integer);
    }

    @Override
    public NoticeDto get(Integer integer) throws Exception {
        return noticeRepository.selectOne(integer);
    }

    @Override
    public List<NoticeDto> get() throws Exception {
        return noticeRepository.select();
    }


    // 공지사항 기본 목록 가져오기 (페이징)
    public List<NoticeDto> getNoticePage(int pageNo) {
        PageHelper.startPage(pageNo, 5); // 페이지 당 10개의 항목 표시
        return noticeRepository.getNoticePage();
    }

    // 검색 결과 가져오기 (페이징)
    public List<NoticeDto> getFindPage(int pageNo, Search search) {
        PageHelper.startPage(pageNo, 5); // 페이지 당 10개의 항목 표시
        return noticeRepository.getFindPage(search);
    }

    // 메인 페이지에서 사용할거
    public List<NoticeDto> getTop3Notices() {
        return noticeRepository.selectTop3Notices();
    }

}
