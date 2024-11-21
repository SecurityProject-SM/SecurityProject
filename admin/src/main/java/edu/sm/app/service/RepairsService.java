package edu.sm.app.service;


import com.github.pagehelper.PageHelper;
import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.RepairsDto;
import edu.sm.app.dto.Search;
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

    public boolean suc(Integer repairId) {
        int rowsAffected = repairsRepository.suc(repairId);
        return rowsAffected > 0;
    }


//    public List<RepairsDto> getRepairsPage(int pageNo) {
//        PageHelper.startPage(pageNo, 10); // 페이지당 10개의 항목 표시
//        return repairsRepository.getRepairs();
//    }
}
