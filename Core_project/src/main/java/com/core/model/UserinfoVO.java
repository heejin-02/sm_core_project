package com.core.model;

import java.time.LocalDateTime;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserinfoVO { //유저정보
	
	private String id; //아이디
	private String pw; // 비밀번호
 	private String nick; // 닉네임
	private String region; // 지역
	private String id_card; // 신분증 사진
	private String is_approved; // 인증 여부
	private LocalDateTime joined_at; // 가입일자
	
	private MultipartFile file;

}
