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
public class RepairsDto {
    private int repairId; //PK
    private String buildingId; //FK
    private String iotId; //FK
    private String repairStat;
    private LocalDateTime repairStart;
    private String repairLoc;
}