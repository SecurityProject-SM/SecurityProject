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
public class ParkLogDto {
    private int parkLogId; //PK
    private int parkId; //FK
    private String carNum;
    private LocalDateTime carIn;
    private LocalDateTime carOut;
    private int carPay;

    public boolean getParkStat(){return false;}
}