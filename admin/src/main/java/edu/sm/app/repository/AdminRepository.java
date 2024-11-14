package edu.sm.app.repository;

import edu.sm.app.dto.AdminsDto;
import edu.sm.app.dto.ParkDto;
import edu.sm.app.frame.SBRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface AdminRepository extends SBRepository<String, AdminsDto> {

    // 카카오 ID로 사용자 조회 메서드
    AdminsDto findByKakaoId(String kakaoId);

    // 기본 사용자 정보만 삽입하는 메서드
    void insertKakaoUser(AdminsDto usersDto);
    void updateAdditionalInfo(AdminsDto usersDto);
}
