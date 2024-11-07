package edu.sm.app.repository;

import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.Search;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface NoticeRepository extends SBRepository<Integer, NoticeDto> {
    // 기본 공지사항 목록 조회 (페이징 처리됨)
    List<NoticeDto> getNoticePage();

    // 검색 조건에 따른 공지사항 목록 조회 (페이징 처리됨)
    List<NoticeDto> getFindPage(Search search);
}
