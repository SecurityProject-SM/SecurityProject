package edu.sm.app.service;


import edu.sm.app.dto.IotDto;
import edu.sm.app.dto.ParkDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.IotRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class IotServcie implements SBService<String, IotDto> {

    final IotRepository iotRepository;

    @Override
    public void add(IotDto iotDto) throws Exception {
        iotRepository.insert(iotDto);
    }

    @Override
    public void modify(IotDto iotDto) throws Exception {
        iotRepository.update(iotDto);
    }

    @Override
    public void del(String s) throws Exception {
        iotRepository.delete(s);
    }

    @Override
    public IotDto get(String s) throws Exception {
        return iotRepository.selectOne(s);
    }

    @Override
    public List<IotDto> get() throws Exception {
        return iotRepository.select();
    }


    public boolean getIotStatusById(String iotId) throws Exception{
//        Boolean status = iotRepository.getIotStatusById(iotId);
//        return status!= null && status;
        return iotRepository.getIotStatusById(iotId);
    }
//    public List<IotDto> getIotStatusList() throws Exception {
//        return iotRepository.select();
//    }
}
