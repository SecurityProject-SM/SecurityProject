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
public class HouseLogDto {
    private int logId;
    private String houseId;
    private String houseCat;
    private String houseValue;
    private LocalDateTime logDate;
}