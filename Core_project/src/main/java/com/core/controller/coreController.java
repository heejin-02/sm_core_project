package com.core.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class coreController {

	// 기본 메서드
	@RequestMapping("/")
	public String main() {
		return "similar_search";
	}
	
	//회원가입 메서드(join)
	@RequestMapping("/join")
	public String join() {
		return "join";
	}
	

	//로그인 메서드(login)
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	//정책 제안 올리기 메서드(proposal_post)
	
	
	
	
	
	//정책 제안 목록 띄우기 메서드(proposal_list)
	
	
	
	
	
	//유사도 목록 띄우기 메서드(similar_search)
	
	
	
	
	
	//토론방 목록 띄우기 메서드(discuss_list)
	
	
	
	
	
	//토론방 생성하기 메서드(discuss_post)
	
	
	
	
	
	
	//토론방 안 채팅 띄우기 메서드(discuss_room)
	// (제일 나중에하기)
}
