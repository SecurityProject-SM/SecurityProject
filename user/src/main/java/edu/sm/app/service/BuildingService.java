package edu.sm.app.service;

import edu.sm.app.dto.BuildingDto;
import edu.sm.app.dto.ParkDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.BuildingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BuildingService implements SBService<String, BuildingDto> {

    final BuildingRepository buildingRepository;

    @Override
    public void add(BuildingDto buildingDto) throws Exception {
        buildingRepository.insert(buildingDto);
    }

    @Override
    public void modify(BuildingDto buildingDto) throws Exception {
        buildingRepository.update(buildingDto);
    }

    @Override
    public void del(String s) throws Exception {
        buildingRepository.delete(s);
    }

    @Override
    public BuildingDto get(String s) throws Exception {
        return buildingRepository.selectOne(s);
    }

    @Override
    public List<BuildingDto> get() throws Exception {
        return buildingRepository.select();
    }

    @Override
    public List<ParkDto> findByCarNumber() throws Exception {
        return List.of();
    }
}