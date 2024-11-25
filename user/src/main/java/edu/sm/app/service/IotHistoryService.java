package edu.sm.app.service;

import edu.sm.app.dto.AvgTHDto;
import edu.sm.app.dto.IotHistoryDto;
import edu.sm.app.dto.ParkDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.IotHistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class IotHistoryService implements SBService<Integer, IotHistoryDto> {

    final IotHistoryRepository iotHistoryRepository;

    @Override
    public void add(IotHistoryDto iotHistoryDto) throws Exception {
        iotHistoryRepository.insert(iotHistoryDto);
    }

    @Override
    public void modify(IotHistoryDto iotHistoryDto) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public IotHistoryDto get(Integer integer) throws Exception {
        return iotHistoryRepository.selectOne(integer);
    }

    @Override
    public List<IotHistoryDto> get() throws Exception {
        return iotHistoryRepository.select();
    }

    public List<IotHistoryDto> selectLatestIotHistory() throws Exception {
        return iotHistoryRepository.selectLatestIotHistory();
    }

    public AvgTHDto selectAvgTH() throws Exception{
        return iotHistoryRepository.selectAvgTH();
    }

    public Double getElec() throws Exception {
        return iotHistoryRepository.getElec();
    }

    public Map<String, Object> chartdata() throws Exception {
        Map<String, Object> rawData = iotHistoryRepository.chartdata();

        LocalDateTime logDate = (LocalDateTime) rawData.get("total_time");
        String formattedDate = logDate != null ? logDate.toString() : null;

        rawData.put("total_time", formattedDate);
        return rawData;
    }

}
