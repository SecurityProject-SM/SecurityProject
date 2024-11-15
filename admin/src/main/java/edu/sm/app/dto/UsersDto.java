package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class UsersDto {
    private String userId; //PK
    private String userPwd;
    private String userTel;
    private String userMail;
    private String userName;
    private boolean userPower;
    private boolean userFlag;
}
