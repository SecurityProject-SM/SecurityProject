package edu.sm.app.repository;

import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.RepairsDto;
import edu.sm.app.dto.Search;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface RepairsRepository extends SBRepository<Integer, RepairsDto> {

    List<NoticeDto> getFindPage(Search search);
//    List<RepairsDto> getRepairs();

    //완료버튼
    int suc(Integer repairId);
}

