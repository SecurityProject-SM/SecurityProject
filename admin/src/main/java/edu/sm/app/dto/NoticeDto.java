package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class NoticeDto {
    private int noticeId;   //PK
    private String adminId; //FK
    private String noticeName;
    private String noticeDetail;
    private LocalDateTime noticeTime;
}
