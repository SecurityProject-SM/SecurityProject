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
public class IotHistoryDto {
    private int historyId;
    private String iotId;
    private String valueCategory;
    private double iotValue;
    private LocalDateTime logDate;
}
