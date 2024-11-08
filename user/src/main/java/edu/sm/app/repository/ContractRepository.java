package edu.sm.app.repository;

import edu.sm.app.dto.ContractDto;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ContractRepository extends SBRepository<Integer, ContractDto> {
    ContractDto selectByUserId(String userId);

}
