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
	
<<<<<<< HEAD
	private String id; //아이디
	private String pw; // 비밀번호
 	private String nick; // 닉네임
	private String region; // 지역
	private String id_card; // 신분증 사진
	private String is_approved; // 인증 여부
	private LocalDateTime joined_at; // 가입일자
	

=======
	private String ID; //아이디
	private String PW; // 비밀번호
 	private String NICK; // 닉네임
	private String REGION; // 지역
	private String ID_CARD; // 신분증 사진
	private String IS_APPROVED; // 인증 여부
	private LocalDateTime JOINED_AT; // 가입일자
	public void join(UserinfoVO vo) {
	}
>>>>>>> 94b28914d81d342c37052e4d4223ef832116a89f
}
