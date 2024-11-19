package edu.sm.app.repository;

import edu.sm.app.dto.IotDto;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface IotRepository extends SBRepository<String, IotDto> {
    String getIotStatusById(String iotId);
}
