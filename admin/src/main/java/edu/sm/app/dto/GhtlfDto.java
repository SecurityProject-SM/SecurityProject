package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GhtlfDto {
    private int ghtlfid;
    private int room;
    private String stday;
    private String edday;
    private int deposit;
    private int dnjftp;
    private int epty;
    private String dlfma;
    private String tel;
    private String bname;
}
