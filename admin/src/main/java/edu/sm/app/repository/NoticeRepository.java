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
    List<NoticeDto> getNoticePage();
    List<NoticeDto> getFindPage(Search search);

    // 메인 페이지에서 쓸거임
    List<NoticeDto> selectTop3Notices();

}
