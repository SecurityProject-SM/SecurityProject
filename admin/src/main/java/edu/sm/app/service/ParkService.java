package edu.sm.app.service;

import edu.sm.app.dto.ParkDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.ParkRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ParkService implements SBService<Integer, ParkDto> {

    final ParkRepository parkRepository;

    @Override
    public void add(ParkDto parkDto) throws Exception {
        parkRepository.insert(parkDto);
    }

    @Override
    public void modify(ParkDto parkDto) throws Exception {
        parkRepository.update(parkDto);
    }

    @Override
    public void del(Integer integer) throws Exception {
        parkRepository.delete(integer);
    }

    @Override
    public ParkDto get(Integer integer) throws Exception {
        return parkRepository.selectOne(integer);
    }

    @Override
    public List<ParkDto> get() throws Exception {
        return parkRepository.select();
    }
}
