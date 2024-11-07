package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class HouseDto {
    private String houseId; //PK
    private String buildingId; //FK
    private String houseArea;
    private String houseFloor;
    private Boolean isEmpty;
}
