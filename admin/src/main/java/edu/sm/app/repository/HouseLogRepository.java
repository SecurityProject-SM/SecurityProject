package edu.sm.app.repository;

import edu.sm.app.dto.HouseLogDto;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface HouseLogRepository extends SBRepository<Integer, HouseLogDto> {
}
