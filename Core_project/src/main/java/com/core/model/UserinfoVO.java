package com.core.model;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserinfoVO { //유저정보
	
	private String ID; //아이디
	private String PW; // 비밀번호
 	private String NICK; // 닉네임
	private String REGION; // 지역
	private String ID_CARD; // 신분증 사진
	private String IS_APPROVED; // 인증 여부
	private LocalDateTime JOINED_AT; // 가입일자
	public void join(UserinfoVO vo) {
	}
}
