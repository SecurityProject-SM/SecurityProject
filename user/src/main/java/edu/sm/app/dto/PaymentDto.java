package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Getter, Setter, toString, equals, hashCode 자동 생성
@Builder // 빌더 패턴 지원
@AllArgsConstructor // 모든 필드를 포함한 생성자 생성
@NoArgsConstructor // 기본 생성자 생성
public class PaymentDto {
    private String impUid; // 결제 UID
    private String status; // 결제 상태 (e.g., "paid")
}
