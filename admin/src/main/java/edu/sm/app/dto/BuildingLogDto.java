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
public class BuildingLogDto {
    private int logId;
    private String buildingId;
    private String buildingCat;
    private String buildingValue;
    private int buildingFloor;
    private LocalDateTime logDate;
}