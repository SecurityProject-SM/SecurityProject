package edu.sm.app.service;


import edu.sm.app.dto.ParkDto;
import edu.sm.app.dto.RepairsDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.RepairsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RepairsService  implements SBService<Integer, RepairsDto> {
    
    final RepairsRepository repairsRepository;

    @Override
    public void add(RepairsDto repairsDto) throws Exception {
        repairsRepository.insert(repairsDto);
    }

    @Override
    public void modify(RepairsDto repairsDto) throws Exception {
        repairsRepository.update(repairsDto);
    }

    @Override
    public void del(Integer integer) throws Exception {
        repairsRepository.delete(integer);
    }

    @Override
    public RepairsDto get(Integer integer) throws Exception {
        return repairsRepository.selectOne(integer);
    }

    @Override
    public List<RepairsDto> get() throws Exception {
        return repairsRepository.select();
    }

}
