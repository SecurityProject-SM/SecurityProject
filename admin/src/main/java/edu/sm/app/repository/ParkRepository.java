package edu.sm.app.repository;

import edu.sm.app.dto.ParkDto;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ParkRepository extends SBRepository<Integer, ParkDto> {
}
