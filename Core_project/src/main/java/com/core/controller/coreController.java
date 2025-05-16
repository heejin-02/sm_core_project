package com.core.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.core.mapper.CoreMapper;
import com.core.model.UserinfoVO;
import org.springframework.ui.Model;


@Controller
public class coreController {

	   @Autowired
	   private CoreMapper mapper;
		
	// 기본 메서드
	   @RequestMapping("/")
	   public String main() {
	      return "similar_search";
	   }
	   
	//회원가입 메서드(join)

	// 회원가입 페이지에서 form 전송 시 실행되는 메서드
	   @RequestMapping("/join")
	   public String join(@RequestParam("user_pw") String userPw,
	                      @RequestParam("user_pw_confirm") String userPwConfirm,
	                      UserinfoVO vo,
	                      Model model) {

	       // 1) 비밀번호 일치 체크
	       if (!userPw.equals(userPwConfirm)) {
	           model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
	           return "join";  // 비밀번호 틀리면 회원가입 페이지로 다시 이동
	       }

	       // 2) 비밀번호 일치하면 DB에 저장
	       int result = mapper.join(vo);

	       if (result > 0) {
	           return "login";  // 회원가입 성공 시 로그인 페이지 이동
	       } else {
	           model.addAttribute("msg", "회원가입 실패, 다시 시도하세요.");
	           return "join";  // 실패 시 회원가입 페이지로 다시 이동
	       }
	   }
	
	//로그인 메서드(login)
	
	   @RequestMapping("/login")
	    public String login(UserinfoVO vo, HttpSession session,  Model model) {
	        UserinfoVO mvo = mapper.login(vo);

	        if (mvo != null) {
	            session.setAttribute("mvo", mvo); // 로그인 성공 시 세션 저장
	            return "main";
	        } else {
	        	 model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
	             return "login";  // 다시 로그인 페이지로 이동
	        }
	    }

	// 로그아웃 메서드(logout)
	    @RequestMapping("/logout")
	    public String logout(HttpSession session) {
	        session.invalidate(); // 세션 무효화
	        return "main";
	    }

	// 회원정보 수정 페이지로 이동
	    @GetMapping("/update")
	    public String update() {
	        return "update"; // update.jsp 로 이동
	    }

	// 회원정보 수정 실행
	    @PostMapping("/update2")
	    public String update2(UserinfoVO vo, HttpSession session) {
	        System.out.println("수정할 값: " + vo);
	        int result = mapper.update(vo);

	        if (result > 0) {
	            session.setAttribute("mvo", vo); // 세션 업데이트
	            System.out.println("정보수정 성공");
	        } else {
	            System.out.println("정보수정 실패");
	        }

	        return "main";
	    }
	   
	   
	// 회원탈퇴 메서드
	   @RequestMapping("/delete")
	    public String delete(@RequestParam("user_email") String email, HttpSession session) {
	        int cnt = mapper.delete(email);

	        if (cnt > 0) {
	            System.out.println("탈퇴 성공");
	            session.invalidate(); // 세션 종료
	        } else {
	            System.out.println("탈퇴 실패");
	        }

	        return "main";
	    }
	
	//정책 제안 올리기 메서드(proposal_post)
	
	
	
	
	
	//정책 제안 목록 띄우기 메서드(proposal_list)
	
	
	
	
	
	//유사도 목록 띄우기 메서드(similar_search)
	
	
	
	
	
	//토론방 목록 띄우기 메서드(discuss_list)
	
	
	
	
	
	//토론방 생성하기 메서드(discuss_post)
	
	
	
	
	
	
	//토론방 안 채팅 띄우기 메서드(discuss_room)
	// (제일 나중에하기)
}
