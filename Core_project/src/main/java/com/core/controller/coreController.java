package com.core.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.core.mapper.CoreMapper;
import com.core.model.UserinfoVO;
import org.springframework.ui.Model;

@Controller
public class coreController {

	@Autowired
	private CoreMapper mapper;

	@RequestMapping("/similar_search")
	public String similarSearch() {
		return "similar_search";
	}

	@RequestMapping("/")
	public String home() {
		return "similar_search";
	}

	// 회원가입 메서드(join)
	// 회원가입 폼 페이지 보여주기 (GET 요청)
	@GetMapping("/join")
	public String joinForm() {
		return "join"; // join.jsp 보여줌
	}

	// 회원가입 처리 (POST 요청)
	@PostMapping("/join")
	public String join(UserinfoVO vo, Model model) {
		
		// 기본값 설정
		vo.setIs_approved("N");
		vo.setJoined_at(LocalDateTime.now());

		// DB 저장
		mapper.join(vo);
		model.addAttribute("id", vo.getId());
		System.out.println("id: " + vo.getId());
		System.out.println("pw: " + vo.getPw());
		System.out.println("nick: " + vo.getNick());
		System.out.println(" region: " + vo.getRegion());
		
		return "redirect:/join?email=" + vo.getId(); // 회원가입 후 이동할 페이지
	}
	


	// 로그인 메서드(login)

	private void model_addAttribute(String string, String id) {
		// TODO Auto-generated method stub

	}

	@RequestMapping("/login")
	public String login(UserinfoVO vo, HttpSession session, Model model) {
		UserinfoVO mvo = mapper.login(vo);

		if (mvo != null) {
			session.setAttribute("mvo", mvo); // 로그인 성공 시 세션 저장
			return "similar_search";
		} else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "login"; // 다시 로그인 페이지로 이동
		}
	}

	// 로그아웃 메서드(logout)
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 무효화
		return "similar_search";
	}

	// 회원탈퇴 메서드
	@RequestMapping("/delete")
	public String delete(@RequestParam("ID") String id, HttpSession session) {
		int cnt = mapper.delete(id);
		if (cnt > 0) {
			session.invalidate();
		}
		return "similar_search";
	}

	// 정책 제안 올리기 메서드(proposal_post)

	// 정책 제안 목록 띄우기 메서드(proposal_list)

	// 유사도 목록 띄우기 메서드(similar_search)

	// 토론방 목록 띄우기 메서드(discuss_list)

	// 토론방 생성하기 메서드(discuss_post)

	// 토론방 안 채팅 띄우기 메서드(discuss_room)
	// (제일 나중에하기)
}