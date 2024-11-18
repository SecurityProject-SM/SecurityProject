package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class AdminsDto {
    private String adminId; //PK
    private String buildingId; //FK
    private String adminPwd;
    private String adminTel;
    private String adminEmail;
    private String adminName;
    private int adminPower;
}
