package edu.sm.app.service;

import com.github.pagehelper.PageHelper;
import edu.sm.app.dto.UsersDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.UsersRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class UsersService implements SBService<String, UsersDto> {

    final UsersRepository usersRepository;

    @Override
    public void add(UsersDto usersDto) throws Exception {
        usersRepository.insert(usersDto);
    }

    @Override
    public void modify(UsersDto usersDto) throws Exception {
        usersRepository.update(usersDto);
    }

    @Override
    public void del(String s) throws Exception {
        usersRepository.delete(s);
    }

    @Override
    public UsersDto get(String s) throws Exception {
        return usersRepository.selectOne(s);
    }

    @Override
    public List<UsersDto> get() throws Exception {
        return usersRepository.select();
    }

    public List<UsersDto> getUsersByPower(int pageNo) {
        PageHelper.startPage(pageNo, 10);  // 페이지당 10개의 항목 표시
        return usersRepository.getUsersByPower();
    }


    // 카카오
    public void addKakaoUser(UsersDto usersDto) throws Exception {
        usersRepository.insertKakaoUser(usersDto);
    }

    public UsersDto findByKakaoId(String kakaoId) throws Exception {
        return usersRepository.findByKakaoId(kakaoId);
    }

    public void updateAdditionalInfo(UsersDto usersDto) throws Exception {
        log.info("Updating additional info for user ID: {}", usersDto.getUserId());
        usersRepository.updateAdditionalInfo(usersDto);
    }
}