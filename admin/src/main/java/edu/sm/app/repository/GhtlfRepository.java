package edu.sm.app.repository;

import edu.sm.app.dto.GhtlfDto;

import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
@Mapper
public interface GhtlfRepository extends SBRepository<Integer, GhtlfDto> {
    void updateus(GhtlfDto ghtlfDto);
    void updatect(GhtlfDto ghtlfDto);

    List<GhtlfDto> rentcalc();
    int vacancy();

}



