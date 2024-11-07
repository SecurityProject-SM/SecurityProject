package edu.sm.app.repository;

import edu.sm.app.dto.ParkLogDto;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ParkLogRepository extends SBRepository<Integer, ParkLogDto> {
}
