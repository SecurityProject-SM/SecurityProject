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
public class ContractDto {
    private int contractId; //PK
    private String houseId; //FK
    private String userId;  //FK
    private LocalDateTime contractDay;
    private LocalDateTime contractEnd;
    private int contractPay;
    private int contractDeposit;
}
