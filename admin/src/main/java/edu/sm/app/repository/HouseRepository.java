package edu.sm.app.repository;


import edu.sm.app.dto.HouseDto;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface HouseRepository extends SBRepository<String, HouseDto> {
}
