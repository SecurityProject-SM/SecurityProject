package edu.sm.app.service;

import edu.sm.app.dto.HouseDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.HouseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class HouseService implements SBService<String, HouseDto> {

    final HouseRepository houseRepository;

    @Override
    public void add(HouseDto houseDto) throws Exception {
        houseRepository.insert(houseDto);
    }

    @Override
    public void modify(HouseDto houseDto) throws Exception {
        houseRepository.update(houseDto);
    }

    @Override
    public void del(String s) throws Exception {
        houseRepository.delete(s);
    }

    @Override
    public HouseDto get(String s) throws Exception {
        return houseRepository.selectOne(s);
    }

    @Override
    public List<HouseDto> get() throws Exception {
        return houseRepository.select();
    }
}