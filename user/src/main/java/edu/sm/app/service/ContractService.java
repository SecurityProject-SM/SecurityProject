package edu.sm.app.service;

import edu.sm.app.dto.ContractDto;
import edu.sm.app.dto.ParkDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.ContractRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContractService implements SBService<Integer, ContractDto> {
    
    final ContractRepository contractRepository;

    @Override
    public void add(ContractDto contractDto) throws Exception {
        contractRepository.insert(contractDto);
    }

    @Override
    public void modify(ContractDto contractDto) throws Exception {
        contractRepository.update(contractDto);
    }

    @Override
    public void del(Integer integer) throws Exception {
        contractRepository.delete(integer);
    }

    @Override
    public ContractDto get(Integer integer) throws Exception {
        return contractRepository.selectOne(integer);
    }

    @Override
    public List<ContractDto> get() throws Exception {
        return contractRepository.select();
    }

    public ContractDto getContractByUserId(String userId) throws Exception {
        return contractRepository.selectByUserId(userId);
    }





}
