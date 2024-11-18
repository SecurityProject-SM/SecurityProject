package edu.sm.app.service;

import edu.sm.app.dto.ParkDto;
import edu.sm.app.dto.ParkLogDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.ParkLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ParkLogService implements SBService<Integer, ParkLogDto> {

    final ParkLogRepository parkLogRepository;

    @Override
    public void add(ParkLogDto parkLogDto) throws Exception {
        parkLogRepository.insert(parkLogDto);
    }

    @Override
    public void modify(ParkLogDto parkLogDto) throws Exception {
        parkLogRepository.update(parkLogDto);
    }

    @Override
    public void del(Integer integer) throws Exception {
        parkLogRepository.delete(integer);
    }

    @Override
    public ParkLogDto get(Integer integer) throws Exception {
        return parkLogRepository.selectOne(integer);
    }

    @Override
    public List<ParkLogDto> get() throws Exception {
        return parkLogRepository.select();
    }


//    public List<ParkLogDto> findByCarNum(String carNum) throws Exception {
//        return parkLogRepository.findByCarNum(carNum);
//    }
}
