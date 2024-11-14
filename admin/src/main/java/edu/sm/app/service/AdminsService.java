package edu.sm.app.service;

import edu.sm.app.dto.AdminsDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.AdminRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminsService implements SBService<String, AdminsDto> {

    final AdminRepository adminRepository;

    @Override
    public void add(AdminsDto adminsDto) throws Exception {
        adminRepository.insert(adminsDto);
    }

    @Override
    public void modify(AdminsDto adminsDto) throws Exception {
        adminRepository.update(adminsDto);
    }

    @Override
    public void del(String string) throws Exception {
        adminRepository.delete(string);
    }

    @Override
    public AdminsDto get(String string) throws Exception {
        return adminRepository.selectOne(string);
    }

    @Override
    public List<AdminsDto> get() throws Exception {
        return adminRepository.select();
    }

}