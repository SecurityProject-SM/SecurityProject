package edu.sm.app.repository;

import edu.sm.app.dto.AvgTHDto;
import edu.sm.app.dto.IotHistoryDto;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface IotHistoryRepository extends SBRepository<Integer, IotHistoryDto> {
    List<IotHistoryDto> selectLatestIotHistory();
    AvgTHDto selectAvgTH();
    Double getElec();

}
