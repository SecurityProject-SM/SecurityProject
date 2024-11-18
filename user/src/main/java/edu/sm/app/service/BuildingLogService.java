package edu.sm.app.service;

import edu.sm.app.dto.BuildingLogDto;
import edu.sm.app.dto.ParkDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.BuildingLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BuildingLogService implements SBService<Integer, BuildingLogDto> {

    final BuildingLogRepository buildingLogRepository;

    @Override
    public void add(BuildingLogDto buildingLogDto) throws Exception {
        buildingLogRepository.insert(buildingLogDto);
    }

    @Override
    public void modify(BuildingLogDto buildingLogDto) throws Exception {
        buildingLogRepository.update(buildingLogDto);
    }

    @Override
    public void del(Integer integer) throws Exception {
        buildingLogRepository.delete(integer);
    }

    @Override
    public BuildingLogDto get(Integer integer) throws Exception {
        return buildingLogRepository.selectOne(integer);
    }

    @Override
    public List<BuildingLogDto> get() throws Exception {
        return buildingLogRepository.select();
    }




}
