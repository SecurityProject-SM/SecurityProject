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
public class ParkDto {
    private int parklogId; // PK
    private int parkId; // FK
    private String carNum;
    public LocalDateTime carIn; // 입차 시간
    public LocalDateTime carOut; // 출차 시간
    private int carPay; // 주차 요금

    public boolean getParkStat() {
        return false;
    }
}
