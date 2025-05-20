package com.core.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.core.model.UserinfoVO;

@Mapper
public interface CoreMapper {

	//로그인
	 public UserinfoVO login(UserinfoVO vo);
	// 회원가입
	 public void join(UserinfoVO vo);
	// 회원탈퇴
	 public int delete(String user_email);
	 

}
