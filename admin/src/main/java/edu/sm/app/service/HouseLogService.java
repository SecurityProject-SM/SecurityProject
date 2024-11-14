package edu.sm.app.service;

import edu.sm.app.dto.HouseLogDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.HouseLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class HouseLogService implements SBService<Integer, HouseLogDto> {

    final HouseLogRepository houseLogRepository;

    @Override
    public void add(HouseLogDto houseLogDto) throws Exception {
        houseLogRepository.insert(houseLogDto);
    }

    @Override
    public void modify(HouseLogDto houseLogDto) throws Exception {
        houseLogRepository.update(houseLogDto);
    }

    @Override
    public void del(Integer integer) throws Exception {
        houseLogRepository.delete(integer);
    }

    @Override
    public HouseLogDto get(Integer integer) throws Exception {
        return houseLogRepository.selectOne(integer);
    }

    @Override
    public List<HouseLogDto> get() throws Exception {
        return houseLogRepository.select();
    }
}
