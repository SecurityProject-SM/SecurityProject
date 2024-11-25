package edu.sm.app.repository;

import edu.sm.app.dto.ParkLogDto;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface ParkLogRepository extends SBRepository<Integer, ParkLogDto> {
    List<ParkLogDto> findByCarNum(@Param("carNum") String carNum);
    List<Map<String, Object>> carPaySum();
}
