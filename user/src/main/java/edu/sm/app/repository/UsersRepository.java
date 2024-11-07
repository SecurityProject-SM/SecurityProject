package edu.sm.app.repository;

import edu.sm.app.dto.UsersDto;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UsersRepository extends SBRepository<String, UsersDto> {
    // 카카오 ID로 사용자 조회 메서드
    UsersDto findByKakaoId(String kakaoId);

    // 기본 사용자 정보만 삽입하는 메서드
    void insertKakaoUser(UsersDto usersDto);
    void updateAdditionalInfo(UsersDto usersDto);
}
