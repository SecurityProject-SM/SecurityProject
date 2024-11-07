package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BuildingDto {
    private String buildingId; //PK
    private String buildingLoc;
    private int totalFloor;
    private int totalUnits;
    private Double lng;
    private Double lat;
}