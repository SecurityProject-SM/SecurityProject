package edu.sm.app.service;

import edu.sm.app.dto.GhtlfDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.GhtlfRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class GhtlfService implements SBService<Integer, GhtlfDto> {

    final GhtlfRepository ghtlfRepository;

    @Override
    public void add(GhtlfDto ghtlfDto) throws Exception {
        ghtlfRepository.insert(ghtlfDto);
    }

    @Override
    public void modify(GhtlfDto ghtlfDto) throws Exception {
        ghtlfRepository.update(ghtlfDto);
    }

    @Override
    public void del(Integer id) throws Exception {
        ghtlfRepository.delete(id);
    }

    @Override
    public GhtlfDto get(Integer id) throws Exception {
        return ghtlfRepository.selectOne(id);
    }

    @Override
    public List<GhtlfDto> get() throws Exception {
        return ghtlfRepository.select();
    }
}
